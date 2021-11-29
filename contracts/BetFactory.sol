// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Bet.sol";
// TODO emit events for all major changes
// TODO don't use ETH. The gas fees are retarded 
// Solang Solidity Compiler allows you to deploy .sol smart contracts to Solana blockchain

contract BetFactory{

    // TODO this gettter is requiring a uint256 to index the Bet[] and return just 1
    mapping(address => Bet[]) public allBets;
    mapping(address => bool) public allAddresses;
    uint256 public betCounter = 0;

    function createBet(uint256 _wager, string memory _token, string memory _displayName) external{
        betCounter += 1;
        Bet bet = new Bet();
        // allBets[msg.sender].push(bet);
        // allAddresses[msg.sender] = true;
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
    function readSelfBets() public view returns (Bet[] memory){ 
        return allBets[msg.sender];
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