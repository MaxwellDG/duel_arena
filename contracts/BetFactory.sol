// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// TODO don't use ETH retard gas
// Solang Solidity Compiler allows you to deploy .sol smart contracts to Solana blockchain

// TODO You're currently using a normal factory pattern. This is improved gas costs, but it still falls way short
// You should instead be using a cloning pattern. This creates one single bet contract that has all the functions, and then
// all additional 'clones' only require their unique properties, which would get input as variables to the OG implementation

contract Bet {

    address public creator;
    string public displayName;
    uint256 public wager;
    bool public isEven;
    string public token;
    uint256 public betId;


    constructor(address _creator, string memory _displayName, uint256 _wager, bool _isEven, string memory _token, uint256 _betId) {
        creator = _creator;
        displayName = _displayName;
        wager = _wager;
        isEven = _isEven;
        token = _token;
        betId = _betId;
    }

    // function getAllProperties() public view returns(Bet memory){
        
    // }

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

    event CreatedBet(address creator, string displayName, uint256 wager, bool isEven, string token, uint256 betId);

    function createBet(uint256 _wager, bool _isEven, string memory _token, string memory _displayName) external returns(Bet){ 
        betCounter += 1;
        Bet bet = new Bet(msg.sender, _displayName, _wager, _isEven, _token, betCounter);
        emit CreatedBet(msg.sender, _displayName, _wager, _isEven, _token, betCounter);
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