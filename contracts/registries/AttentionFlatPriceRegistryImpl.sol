pragma solidity ^0.4.18;

import "./AttentionFlatPriceRegistry.sol";

contract AttentionFlatPriceRegistryImpl is AttentionFlatPriceRegistry {
  
  mapping(address => uint) public accountToPriceMapping;
  
  function getPrice(address _who) public view returns (uint) {
    return accountToPriceMapping[_who];
  }
  
  function getMyPrice() public view returns (uint) {
    return accountToPriceMapping[msg.sender];
  }
  
  function setMyPrice(uint _price) public {
    require (_price >= 0);
    accountToPriceMapping[msg.sender] = _price;
  }
  
}