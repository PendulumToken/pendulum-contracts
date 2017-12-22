pragma solidity ^0.4.18;

import "../registries/ContractRegistry.sol";

contract Proxy {
  
  address private constant CONTRACT_REGISTRY_ADDRESS = 0x1d3B2638a7cC9f2CB3D298A3DA7a90B67E5506ed;
  
  ContractRegistry internal contractRegistry;
  
  function Proxy() public {
    contractRegistry = ContractRegistry(CONTRACT_REGISTRY_ADDRESS);
  }
  
  function lookupAddress(string contractKey) public view returns (address) {
    return contractRegistry.getAddress(contractKey);
  }
  
}