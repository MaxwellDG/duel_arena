// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Bet {

    address public creator;
    string public displayName;
    uint256 public wager;
    string public token;
    uint256 public betId;

    constructor() {

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