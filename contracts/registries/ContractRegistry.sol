pragma solidity ^0.4.18;

/**
 * @title Contract Registry
 * 
 * @dev Data registry acting as the source-of-truth of the latest version of all contracts, allowing
 * a simple mechanism to contract upgrades. There is only one instance, and it gets uploaded to the blockchain 
 * before all other contracts. The Ping team shall remain the owner of this contract.
 */
contract ContractRegistry {

  function addContract(string contractUrn, address contractAddress) public;

  function removeContract(string contractUrn) public;

  function updateContract(string contractUrn, address contractAddress) public;

  function getAddress(string contractUrn) public view returns (address);
  
  function isExists(string contractUrn) public view returns (bool);
  
}