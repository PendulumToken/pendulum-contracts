pragma solidity ^0.4.18;

/**
 * @title Attention Flat Price Registry
 * 
 * @dev Data registry that stores the flat pricing parameters of each user's attention.
 * This is one of several pricing strategies used to model a user's attention price.
 * 
 * @dev Since this is a datastore, it is intentionally NOT meant to be upgradeable.
 */
contract AttentionFlatPriceRegistry {
  
  function getPrice(address _who) public view returns (uint);
  
  function getMyPrice() public view returns (uint);
  
  function setMyPrice(uint _price) public;
  
}