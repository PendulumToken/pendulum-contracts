pragma solidity ^0.4.18;

import "./AttentionPriceProvider.sol";
import "../extensions/Proxy.sol";
import "../registries/AttentionFlatPriceRegistry.sol";
import "../registries/AttentionMarketPriceRegistry.sol";

contract AttentionFlatPriceProvider is AttentionPriceProvider, Proxy {
  
  function getPrice(address _who, bytes _when) public returns (uint) {
    if (useFlatPriceStrategy(_who)) {
      return getFlatPrice(_who);
    }
    
    if (useMarketPriceStrategy(_who)) {
      return getMarketPrice(_who, _when);
    }
    
    // Unable to find appropriate pricing strategy. This should never happen.
    revert();
  }
  
  function useFlatPriceStrategy(address _who) private pure returns (bool) {
    // To be completed when A/B testing is implemented.
    return true;
  }
  
  function useMarketPriceStrategy(address _who) private pure returns (bool) {
    // To be completed when A/B testing is implemented.
    return false;
  }
  
  function getFlatPrice(address _who) private view returns (uint) {
    AttentionFlatPriceRegistry attentionPriceRegistry = AttentionFlatPriceRegistry(lookupAddress("urn:contract:attention-flat-price-registry"));
    return attentionPriceRegistry.getPrice(_who);
  }
  
  function getMarketPrice(address _who, bytes _when) private view returns (uint) {
    AttentionMarketPriceRegistry attentionPriceRegistry = AttentionMarketPriceRegistry(lookupAddress("urn:contract:attention-market-price-registry"));
    return attentionPriceRegistry.getPrice(_who, _when);
  }
  
}