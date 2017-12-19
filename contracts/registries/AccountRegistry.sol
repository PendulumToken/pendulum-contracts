pragma solidity ^0.4.13;

contract AccountRegistry {
	
	struct Account {
		string name;
		string ipfsHash;
		uint createdAt;
  }
	
	mapping(address => Account) public accounts;
	
	function getSenderAccountIpfsHash() public constant returns (string) {
		return accounts[msg.sender].ipfsHash;
	}

	function registerAccount(string name, string ipfsHash) public returns (bool) {
		accounts[msg.sender].name = name;
		accounts[msg.sender].ipfsHash = ipfsHash;
		return true;
	}
	
}