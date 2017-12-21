pragma solidity ^0.4.18;

contract AccountRegistry {
	
	struct Account {
		string name;
		string ipfsHash;
		uint createdAt;
  }
	
	mapping(address => Account) public accounts;
	
	function getSenderAccountIpfsHash() public view returns (string) {
		return accounts[msg.sender].ipfsHash;
	}

	function registerAccount(string name, string ipfsHash) public returns (bool) {
		accounts[msg.sender].name = name;
		accounts[msg.sender].ipfsHash = ipfsHash;
		return true;
	}
	
}