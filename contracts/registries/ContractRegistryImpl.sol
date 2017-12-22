pragma solidity ^0.4.18;

import "./ContractRegistry.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract ContractRegistryImpl is ContractRegistry, Ownable {
  
  mapping(string => address) contractUrnToAddressMapping;

  function addContract(string contractUrn, address contractAddress) public onlyOwner {
    require(!isExists(contractUrn));
    contractUrnToAddressMapping[contractUrn] = contractAddress;
  }

  function removeContract(string contractUrn) public onlyOwner {
    require(isExists(contractUrn));
    contractUrnToAddressMapping[contractUrn] = 0;
  }

  function updateContract(string contractUrn, address contractAddress) public onlyOwner {
    require(isExists(contractUrn));
    contractUrnToAddressMapping[contractUrn] = contractAddress;
  }

  function getAddress(string contractUrn) public view returns (address) {
    require(isExists(contractUrn));
    return contractUrnToAddressMapping[contractUrn];
  }
  
  function isExists(string contractUrn) public view returns (bool) {
    return contractUrnToAddressMapping[contractUrn] == 0;
  }
  
}