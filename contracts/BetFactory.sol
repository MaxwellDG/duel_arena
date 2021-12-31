// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// TODO don't use ETH retard gas
// Solang Solidity Compiler allows you to deploy .sol smart contracts to Solana blockchain

contract Bet {

    address public creator;
    string public displayName;
    uint256 public wager;
    bool public even;
    string public token;
    uint256 public betId;


    constructor(address _creator, string memory _displayName, uint256 _wager, bool _even, string memory _token, uint256 _betId) {
        creator = _creator;
        displayName = _displayName;
        wager = _wager;
        even = _even;
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

contract BetFactory{

    mapping(address => Bet[]) public allBets;
    mapping(address => bool) public allAddresses;
    uint256 public betCounter = 1;

    event CreatedBet(address creator, string displayName, uint256 wager, bool even, string token, uint256 betId);

    function createBet(uint256 _wager, bool _even, string memory _token, string memory _displayName) external returns(Bet){
        betCounter += 1;
        Bet bet = new Bet(msg.sender, _displayName, _wager, _even, _token, betCounter);
        emit CreatedBet(msg.sender, _displayName, _wager, _even, _token, betCounter);
        allBets[msg.sender].push(bet);
        allAddresses[msg.sender] = true;
        return bet;
    }

    // This doesn't work atm
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

    //Modifiers
    modifier hasOpenBets(){
        // BROKEN ?
        require(allAddresses[msg.sender] == true);
        _;
    }

}

abstract contract Mortal is Bet {

    function kill() public mustBeCreator { 
        selfdestruct(payable(msg.sender));
    }
}