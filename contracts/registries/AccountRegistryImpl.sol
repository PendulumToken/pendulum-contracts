pragma solidity ^0.4.18;

import "./AccountRegistry.sol";

contract AccountRegistryImpl is AccountRegistry {
  
  struct Account {
    string name;
    string ipfsHash;
    uint createdAt;
  }
  
  mapping(address => Account) public accounts;
  
  function addMyAccount(string name, string ipfsHash) public {
    accounts[msg.sender].name = name;
    accounts[msg.sender].ipfsHash = ipfsHash;
  }
  
  function getMyAccountIpfsHash() public view returns (string) {
    return accounts[msg.sender].ipfsHash;
  }

  
  
}