// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// TODO emit events for all major changes
// TODO don't use ETH. The gas fees are retarded 
// Solang Solidity Compiler allows you to deploy .sol smart contracts to Solana blockchain

contract BetFactory{

    // TODO this gettter is requiring a uint256 to index the Bet[] and return just 1
    mapping(address => Bet[]) public allBets;
    mapping(address => bool) public allAddresses;
    uint256 private betCounter = 0;

    function createBet(uint256 _wager, string memory _token, string memory _displayName) external returns (Bet){
        betCounter += 1;
        Bet bet = new Bet(_wager, msg.sender, _token, _displayName, betCounter);
        allBets[msg.sender].push(bet);
        allAddresses[msg.sender] = true;
        return bet;
    }

    function removeBet(uint256 _betId) public hasOpenBets{
        for (uint j = 0; j <= allBets[msg.sender].length; j ++) {  
            if(_betId == allBets[msg.sender][j].betId()){
                delete allBets[msg.sender][j];
                if(allBets[msg.sender].length == 0){
                    allAddresses[msg.sender] = false;
                }
            }
        }
    } 

    // This is kind of working. It returns the contract addresses of the Bets with csv
    function readSelfBets() public view hasOpenBets returns (Bet[] memory){
        return allBets[msg.sender];
    }

    function readBets(string memory _tokenFilter, string memory _betFilter, string memory _displayNameFilter, uint256 pageNum) public view{
        // TODO in some way that's not mega expensive
    }

    //Modifiers
    modifier hasOpenBets(){
        require(allAddresses[msg.sender] == true);
        _;
    }

}

contract Bet {

    // Remember that these all have their own contract address generated on construction too

    address public creator;
    string public displayName;
    uint256 public wager;
    string public token;
    uint256 public betId;

    constructor(uint256 _wager, address _creator, string memory _token, string memory _displayName, uint256 _betId) {
        creator = _creator;
        displayName = _displayName;
        wager = _wager;
        token = _token;
        betId = _betId;
    }

    // Pure
    function compareStringsbyBytes(string memory s1, string memory s2) public pure returns(bool){
        return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }
    
    // Modifiers
    modifier mustBeCreator {
        require(msg.sender == creator);
        _;
    }

    modifier mustMatchBet(Bet incMatchBet) {
        require(incMatchBet.wager() == wager);
        require(compareStringsbyBytes(incMatchBet.token(), token));
        _;
    }
}

abstract contract Mortal is Bet {

    function kill() public mustBeCreator { 
        selfdestruct(payable(msg.sender));
    }
}