pragma solidity ^0.4.18;

import "./extensions/Proxy.sol";
import "./providers/AttentionPriceProvider.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract AttentionMarket is Ownable, Proxy {

  struct AttentionCreditInvoice {
    address buyer;
    bytes when;
    uint quantity;
    uint price;
    uint totalCost;
    uint purchasedAt;
  }

  mapping(address => uint) buyerCredits;
  AttentionCreditInvoice[] buyerInvoices;
	 
  event AttentionCreditBuyEvent(address _buyer, bytes _when, uint _quantity, uint _price, uint _totalCost);
		
  function buyCredits(bytes _when, uint _quantity) public payable {
    uint attentionPrice = getOwnerAttentionPrice(_when);
    uint totalCost = attentionPrice * _quantity;		
    require(msg.value >= totalCost);

    buyerCredits[msg.sender] += _quantity;
    buyerInvoices.push(AttentionCreditInvoice(msg.sender, _when, _quantity, attentionPrice, totalCost, now));
		
    bool overpaid = msg.value > totalCost;
    if (overpaid) {
      uint refund = msg.value - totalCost;
      if (!msg.sender.send(refund)) {
        revert();
      }
    }
		
    AttentionCreditBuyEvent(msg.sender, _when, _quantity, attentionPrice, totalCost);
  }
  
  function redeemCredits(uint _quantity) public {
    // To be completed.
  }
	
  function getMyRemainingCredits() public view returns (uint) {
    return buyerCredits[msg.sender];
  }
  
  function getOwnerAttentionPrice(bytes _when) private returns (uint) {
    AttentionPriceProvider attentionPriceProvider = AttentionPriceProvider(lookupAddress("urn:contract:attention-price-provider"));
    return attentionPriceProvider.getPrice(owner, _when);
  }
	
}