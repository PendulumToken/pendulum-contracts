pragma solidity ^0.4.18;

import "./extensions/Proxy.sol";
import "./providers/AttentionPriceProvider.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract AttentionMarket is Ownable, Proxy {

  uint totalCreditsSold;
  AttentionCreditPurchase[] creditPurchases;
  mapping(address => uint) purchaserCredits;
	 
  event AttentionCreditPurchaseEvent(address _purchaser, uint _quantity, bytes _when, uint _price, uint _totalCost);
	
  struct AttentionCreditPurchase {
    address purchaser;
    uint quantity;
    uint price;
    uint totalCost;
    uint purchasedAt;
  }
	
  function purchaseCredits(uint _quantity, bytes _when) public payable {
    uint attentionPrice = getAttentionPrice(owner, _when);
    uint totalCost = attentionPrice * _quantity;		
    require(msg.value >= totalCost);

    purchaserCredits[msg.sender] += _quantity;
    totalCreditsSold += _quantity;
		
    creditPurchases.push(AttentionCreditPurchase(msg.sender, _quantity, attentionPrice, totalCost, now));
		
    bool overpaid = msg.value > totalCost;
    if (overpaid) {
      uint refund = msg.value - totalCost;
      if (!msg.sender.send(refund)) {
        revert();
      }
    }
		
    AttentionCreditPurchaseEvent(msg.sender, _quantity, _when, attentionPrice, totalCost);
  }
	
  function getRemainingCredits() public view returns (uint) {
    return purchaserCredits[msg.sender];
  }
  
  function getAttentionPrice(address _who, bytes _when) private returns (uint) {
    AttentionPriceProvider attentionPriceProvider = AttentionPriceProvider(lookupAddress("urn:contract:attention-price-provider"));
    return attentionPriceProvider.getPrice(_who, _when);
  }
	
}