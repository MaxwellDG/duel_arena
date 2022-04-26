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

    function matchBet(string memory matchToken, bool matchIsEven) 
    public payable isValidBetMatch(msg.value, matchToken, msg.sender, matchIsEven){
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
    
    // Modifiers
    modifier mustBeCreator {
        require(msg.sender == betData.creator);
        _;
    }

    modifier isValidBetMatch(uint256 matchWager, string memory matchToken, address _matcher, bool matchIsEven) {
        require(matchWager == betData.wager);
        require(compareStringsByBytes(matchToken, betData.token));
        require(_matcher != betData.creator);
        require(!matchIsEven == betData.isEven);
        _;
    }

    // Selfdestruct
    function kill(address _address) external{
        require(_address == address(betData.creator), "These don't match");
        require(address(this).balance > 0, "Contract balance is zero");
        selfdestruct(payable(_address));
    }
}

contract BetFactory{

    mapping(address => Bet[]) public allBets;
    mapping(address => bool) public allAddresses;

    event CreatedBet(address creator, string displayName, uint256 wager, bool isEven, string token);

    receive() external payable{} // Allows contract to receive ether from anywhere

    function createBet(uint256 _wager, bool _isEven, string memory _token, string memory _displayName) external payable returns(Bet){ 
        require(msg.value > 0, "Zero ether has been sent");
        Bet bet = new Bet{value: _wager}(msg.sender, _displayName, _wager, _isEven, _token);
        emit CreatedBet(msg.sender, _displayName, _wager, _isEven, _token);
        allBets[msg.sender].push(bet);
        allAddresses[msg.sender] = true;
        return bet;
    }

    // Note this only returns the bet contract addresses. More needs to be done with web3 and ABI data to get the actual contract object
    function getSelfBets() public view returns (Bet[] memory){ 
        return allBets[msg.sender];
    }

    function getSelfBetsLength() public view returns (uint256){
        return allBets[msg.sender].length;
    }

    function getHasOpenBets() public view returns(bool){
        return allAddresses[msg.sender];
    }

    function readBets(string memory _tokenFilter, string memory _betFilter, string memory _displayNameFilter, uint256 pageNum) public view{
        // TODO in some way that's not mega expensive
    }

    function deleteBet(address _betAddress) public{ // TODO hasOpenBets
        Bet[] memory bets = allBets[msg.sender];
        for(uint j = 0; j < bets.length; j++){ // TODO theres certainly a more efficient way to do this. Look for something like find() in javascript
            Bet bet = bets[j];
            if(address(bet) == _betAddress){
                bet.kill(msg.sender);
                if(allBets[msg.sender].length == 1){
                    delete allBets[msg.sender];
                    allAddresses[msg.sender] = false;
                } else {
                    allBets[msg.sender][j] = allBets[msg.sender][allBets[msg.sender].length - 1];
                    allBets[msg.sender].pop();
                }
                break;
            }
        }
    }

    //Modifiers
    modifier hasOpenBets(){
        // BROKEN ?
        require(allAddresses[msg.sender] == true);
        _;
    }

}

// abstract contract Mortal is Bet {

//     function kill() public mustBeCreator { 
//         selfdestruct(payable(msg.sender));
//     }
// }