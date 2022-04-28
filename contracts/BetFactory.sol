// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract Bet {

    event Withdraw(address winner, uint256 amount, string winnerDisplayName, int txLastDigit, string token);

    struct BetData{
        address payable creator;
        string displayName;
        uint256 wager;
        bool isEven;
        string token;
    }

    BetData public betData;
    address payable matcher;

    constructor(address _creator, string memory _displayName, uint256 _wager, bool _isEven, string memory _token) payable {
        betData = BetData(
            payable(_creator),
            _displayName,
            _wager,
            _isEven,
            _token
        );
    }

    function withdrawToWinner(address payable winner, int txLastDigit, string memory winnerDisplayName) internal{
        emit Withdraw(winner, address(this).balance, winnerDisplayName, txLastDigit, betData.token);
        selfdestruct(winner);
    }

    // TODO this makes more sense in the BetFactoy. Lowers contract creation costs as well as aids in removing the bet from all arrays once finished
    function matchBet(string memory _matchToken, bool _matchIsEven) public payable{
        require(msg.value == betData.wager, "Wager doesn't match");
        require(compareStringsByBytes(_matchToken, betData.token), "Token doesn't match");
        require(msg.sender != betData.creator, "Creator and matcher are the same");
        require(!_matchIsEven == betData.isEven, "Both bet same bet");
        matcher = payable(msg.sender);
        // TODO CHAINLINK RNG
        // address payable winner = didCreatorWin ? betData.creator : matcher;
        // string memory winnerDisplayName = didCreatorWin ? betData.displayName : matchDisplayName;
        // withdrawToWinner(winner, txLastDigit, winnerDisplayName);
    }

    // Pure
    function compareStringsByBytes(string memory s1, string memory s2) public pure returns(bool){
        return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }

    //View
    function returnBalance() public view returns(uint){
        return address(this).balance;
    }
    
    // Selfdestruct
    function kill(address _address) external{
        require(_address == address(betData.creator), "These don't match");
        require(address(this).balance > 0, "Contract balance is zero");
        selfdestruct(payable(_address));
    }
}

contract BetFactory{

    // TODO look into Swarm for distributed data storage. The setup below clearly won't scale. Get this project working first, 
    // then state this intention in the first line of the README

    Bet[] public allBets;
    mapping(address => Bet[]) public betsByWallet;
    mapping(string => Bet[]) public betsByToken; 
    mapping(string => Bet[]) public betsByDisplayName;

    event CreatedBet(address creator, string displayName, uint256 wager, bool isEven, string token);

    receive() external payable{} // Allows contract to receive ether from anywhere

    function createBet(uint256 _wager, bool _isEven, string memory _token, string memory _displayName) external payable returns(Bet){ 
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
    function get25Bets(string memory _filter, int _pageNum, string memory _input) public view returns (Bet[] memory) {
        // CHECK if this works if the upper index is too high. Might have to say like 'if length is < s then change end of slice
        int s = _pageNum * 25;
        if(filter == "all"){
            return allBets[s:(s + 25)];
        } else if(filter == "token"){
            return betsByToken[_input][s:(s + 25)];
        } else if(filter == "displayName") {
            return betsByDisplayName[_input][s:(s + 25)];
        } else {
            return betsByWallet[msg.sender][s:(s + 25)]; // Retrieve self bets
        }
    }

    function deleteFromArray(Bet[] storage arr, Bet bet) internal {
        for(uint i = 0; i < arr.length; i++){ 
            if(address(bet) == address(arr[i])){
                 if(arr[i].length == 1){
                        delete arr[i];
                    } else {
                        arr[i] = arr[arr.length - 1];
                        arr.pop();
                    }
            }
        }
    }

    function deleteBet(address _betAddress) public {
        Bet[] memory bets = betsByWallet[msg.sender];
        for(uint j = 0; j < bets.length; j++){ 
            if(address(bet) == _betAddress){
                deleteFromArray(allBets, bets[j]);
                deleteFromArray(betsByWallet[msg.sender], bets[j]);
                deleteFromArray(betsByToken[bet.betData.token], bets[j]);
                deleteFromArray(betsByDisplayName[bet.betData.displayName], bets[j]);
            }
            bet.kill(msg.sender);
            break;
            }
        }
    }
}