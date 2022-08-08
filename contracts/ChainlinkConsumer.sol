// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";


// Note to future Max - don't forget that you have to go on the official ChainLink website and make/use a subscription account there.
// Then you add LINK to it on Rinkbey (from a faucet). Use the subscription ID in the deployment of this contract, then go back to the subscription
// and add this newly deployed contract as a consumer. Then you can actually use the service.


contract VRFv2Consumer is VRFConsumerBaseV2 {
  VRFCoordinatorV2Interface COORDINATOR;

  uint64 s_subscriptionId;
  address s_owner;

  // Rinkeby coordinator. For other networks,
  // see https://docs.chain.link/docs/vrf-contracts/#configurations
  address vrfCoordinator = 0x6168499c0cFfCaCD319c818142124B7A15E857ab;

  // The gas lane to use, which specifies the maximum gas price to bump to.
  // For a list of available gas lanes on each network,
  // see https://docs.chain.link/docs/vrf-contracts/#configurations
  bytes32 keyHash = 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;

  uint32 callbackGasLimit = 100000;
  uint16 requestConfirmations = 3;
  uint32 numWords =  1;

  // While pending, store a mapping of the unique request id to the address (the bet smart contract (TBD or possibly always the factory contract, but with an ID for the bet involved)) that requested it 
  mapping(uint256 => address) requestIdToBetAddress;

  constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
    COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
    s_owner = msg.sender;
    s_subscriptionId = subscriptionId;
  }

  // Assumes the subscription is funded sufficiently.
  function requestRandomWords(address _betAddress) external onlyOwner {
    // Will revert if subscription is not set and funded.
    uint256 s_requestId = COORDINATOR.requestRandomWords(
      keyHash,
      s_subscriptionId,
      requestConfirmations,
      callbackGasLimit,
      numWords
    );
    requestIdToBetAddress[s_requestId] = _betAddress;
  }
  
  function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
    
    // TODO send back to the Bet contract with withdrawToWinner(randomWords[0])
  }

  modifier onlyOwner() {
    require(msg.sender == s_owner);
    _;
  }
}
