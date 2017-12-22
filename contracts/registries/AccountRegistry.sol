pragma solidity ^0.4.18;

contract AccountRegistry {

  function addMyAccount(string name, string ipfsHash) public;

  function getMyAccountIpfsHash() public view returns (string);
	
}