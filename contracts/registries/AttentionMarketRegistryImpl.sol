pragma solidity ^0.4.18;

import "./AttentionMarketRegistry.sol";

contract AttentionMarketRegistryImpl is AttentionMarketRegistry {

  AttentionMarketEntry[] public marketEntries;
  mapping(address => uint) public marketEntryIndexes;
  
  struct AttentionMarketEntry {
    address ownerAddress;
    address marketAddress;
    string ipfsHash;
    uint registeredAt;
  }
  
  function registerMarket(address _marketAddress, string _ipfsHash) public {
    marketEntries.push(AttentionMarketEntry(msg.sender, _marketAddress, _ipfsHash, now));
    marketEntryIndexes[msg.sender] = marketEntries.length - 1;
  }
  
  function getMarketAddress(address _who) public view returns (address) {
    uint index = marketEntryIndexes[_who];
    return marketEntries[index].marketAddress;
  }
  
  function getMarketIpfsHash(address _who) public view returns (string) {
    uint index = marketEntryIndexes[_who];
    return marketEntries[index].ipfsHash;
  }
  
  function getMarketRegisteredAt(address _who) public view returns (uint) {
    uint index = marketEntryIndexes[_who];
    return marketEntries[index].registeredAt;
  }
  
}