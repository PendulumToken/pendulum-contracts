pragma solidity ^0.4.18;

contract AttentionMarketRegistry {

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
	
	function getMarketAddress(address accountAddress) public view returns (address) {
		uint marketEntryIndex = marketEntryIndexes[accountAddress];
		return marketEntries[marketEntryIndex].marketAddress;
	}
	
	function getMarketIpfsHash(address accountAddress) public view returns (string) {
		uint marketEntryIndex = marketEntryIndexes[accountAddress];
		return marketEntries[marketEntryIndex].ipfsHash;
	}
	
	function getMarketRegisteredAt(address accountAddress) public view returns (uint) {
		uint marketEntryIndex = marketEntryIndexes[accountAddress];
		return marketEntries[marketEntryIndex].registeredAt;
	}
	
}