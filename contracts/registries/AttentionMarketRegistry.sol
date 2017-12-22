pragma solidity ^0.4.18;

contract AttentionMarketRegistry {
	
  function addMyMarket(address _marketAddress, string _ipfsHash) public;
	
  function getMarketAddress(address _who) public view returns (address);
	
  function getMarketIpfsHash(address _who) public view returns (string);
	
  function getMarketRegisteredAt(address _who) public view returns (uint);
	
}