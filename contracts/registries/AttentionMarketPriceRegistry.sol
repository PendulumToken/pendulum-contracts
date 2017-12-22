pragma solidity ^0.4.18;

/**
 * @title Attention Market Price Registry
 * 
 * @dev Data registry that stores the market-based (supply-demand) pricing parameters of each user's attention.
 * This is one of several pricing strategies used to model a user's attention price.
 * 
 * @dev Since this is a datastore, it is intentionally NOT meant to be upgradeable.
 * 
 * @author Hwi Yong Song
 */
contract AttentionMarketPriceRegistry {
  
  function getPrice(address _who, bytes _when) public view returns (uint);
  
}