// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract Bet {

    event Withdraw(address winner, uint256 amount, string token);

    struct BetData{
        address payable creator;
        string displayName;
        uint256 wager;
        bool isEven;
        string token;
    }

    address payable matcher;
    BetData public betData;

    constructor(address _creator, string memory _displayName, uint256 _wager, bool _isEven, string memory _token) payable {
        betData = BetData(
            payable(_creator),
            _displayName,
            _wager,
            _isEven,
            _token
        );
    }

    function withdrawToWinner(uint256 _randomNumber) external isFromChainlink{
        address payable winner;
        if((_randomNumber % 2 == 0 && betData.isEven) || (_randomNumber % 2 == 1 && !betData.isEven)){
            winner = betData.creator;
        } else {
            winner = matcher;
        }
        emit Withdraw(winner, address(this).balance, betData.token);
        selfdestruct(winner);
    }

    // View
    function getBetData() public view returns(BetData memory){
        return betData;
    }

    //modifier
    modifier isFromChainlink(){
        require(msg.sender == '<ChainlinkConsumer address>'); // TODO get real address
        _;
    }
    
    // Selfdestruct
    function kill(address _address) external{
        require(_address == address(betData.creator), "Caller is not owner");
        require(address(this).balance > 0, "Contract balance is zero");
        selfdestruct(payable(_address));
    }
}

contract BetFactory{

    // TODO look into Swarm for distributed data storage. The setup below clearly won't scale. Get this project working first. 
    // State this intention in the first line of the README

    Bet[] public allBets;
    mapping(address => Bet[]) public betsByWallet;
    mapping(string => Bet[]) public betsByToken; 
    mapping(string => Bet[]) public betsByDisplayName;

    event CreatedBet(address creator, string displayName, uint256 wager, bool isEven, string token);

    receive() external payable{} // Allows contract to receive ether from anywhere

    function createBet(uint256 _wager, bool _isEven, string calldata _token, string calldata _displayName) external payable returns(Bet){ 
        require(msg.value > 0, "Zero ether has been sent");
        Bet bet = new Bet{value: _wager}(msg.sender, _displayName, _wager, _isEven, _token);
        emit CreatedBet(msg.sender, _displayName, _wager, _isEven, _token);
        betsByWallet[msg.sender].push(bet);
        betsByToken[_token].push(bet);
        betsByDisplayName[_displayName].push(bet);
        allBets.push(bet);
        return bet;
    }

    // Note these only returns the bet contract addresses. More needs to be done with web3 and ABI data to get the actual contract object
    function get25Bets(uint256 _pageNum, int8 _filter, string calldata _input) public view returns (Bet[] memory) {
        Bet[] memory arr = _filter == 0 ?
            allBets : _filter == 1 ?
                betsByWallet[msg.sender] : _filter == 2 ?
                    betsByToken[_input] 
                    :
                    betsByDisplayName[_input];
        uint256 length = arr.length > _pageNum * 25 + 25 ? 25 : arr.length % 25; 
        Bet[] memory buildingArr = new Bet[](length);
        for(uint256 j = 0; j < length; j++){
            buildingArr[j] = arr[(_pageNum * 25) + j];
        }
        return buildingArr;
    }

    function deleteFromArray(Bet[] storage arr, Bet bet) internal {
        for(uint i = 0; i < arr.length; i++){ 
            if(address(bet) == address(arr[i])){
                arr[i] = arr[arr.length - 1];
                arr.pop();
            }
        }
    }

    function deleteBet(address _betAddress) public { // TODO this part is the worst for scaling. Maybe can jump to the correct spot with pagination data?
        Bet[] memory bets = betsByWallet[msg.sender];
        for(uint j = 0; j < bets.length; j++){ 
            if(address(bets[j]) == _betAddress){
                Bet bet = bets[j];
                string memory token = bet.getBetData().token;
                string memory displayName = bet.getBetData().displayName;
                if(allBets.length == 1){
                    delete allBets;
                } else {
                    deleteFromArray(allBets, bet);
                }
                if(betsByWallet[msg.sender].length == 1){
                    delete betsByWallet[msg.sender];
                } else {
                    deleteFromArray(betsByWallet[msg.sender], bet);
                }
                if(betsByToken[token].length == 1){
                    delete betsByToken[token];
                } else {
                    deleteFromArray(betsByToken[token], bets[j]);
                }
                if(betsByDisplayName[displayName].length == 1){
                    delete betsByDisplayName[displayName];
                } else {
                    deleteFromArray(betsByDisplayName[displayName], bets[j]);
                }
                bet.kill(msg.sender);
                break;
            }
        }
    }

    // TODO this makes more sense in the BetFactoy. Lowers contract creation costs as well as aids in removing the bet from all arrays once finished
    function matchBet(address _creator, address _betAddress, string memory _matchToken) public payable{
        require(msg.sender != _creator, "Creator and matcher are the same");
        Bet[] memory bets = betsByWallet[_creator];
        for(uint j = 0; j < bets.length; j++){ 
            if(address(bets[j]) == _betAddress){
                Bet bet = bets[j];
                // TODO set matcher property in Bet contract?
                string memory token = bet.getBetData().token;
                uint256 wager = bet.getBetData().wager;
                require(msg.value == wager, "Wager doesn't match");
                // TODO do this in a safer way by detecting the actual token sent in the value (same with initial sending)
                require(compareStringsByBytes(_matchToken, token), "Tokens don't match"); 
                // TODO CHAINLINK VRM
                // get access to ChainlinkConsumer contract
                //  <contract>.requestRandomWords(address(bet))

                break;
            }
        }
    }

    // Pure
    function compareStringsByBytes(string memory s1, string memory s2) internal pure returns(bool){ 
        return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }
}