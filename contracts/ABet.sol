// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ABet {

    address public creator;
    string public displayName;
    uint256 public wager;
    string public token;
    uint256 public betId;

    constructor(address _creator, string memory _displayName, uint256 _wager, string memory _token, uint256 _betId) {
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

    modifier mustMatchBet(ABet incMatchBet) {
        require(incMatchBet.wager() == wager);
        require(compareStringsbyBytes(incMatchBet.token(), token));
        _;
    }
}