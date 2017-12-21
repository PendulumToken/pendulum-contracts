pragma solidity ^0.4.18;

import "../extensions/Ownable.sol";

contract AttentionMarket is Ownable {
	
  uint creditBasePrice;
  uint totalCreditsSold;
  CreditPurchase[] creditPurchases;
  mapping(address => uint) purchaserCredits;
	 
  event CreditPurchaseEvent(address _purchaser, uint _quantity, uint _price, uint _totalCost);
	
  struct CreditPurchase {
    address purchaser;
    uint quantity;
    uint price;
    uint totalCost;
    uint purchasedAt;
  }
	
  function purchaseCredits(uint _quantity) public payable {
    uint totalCost = creditBasePrice * _quantity;		
    require(msg.value >= totalCost);

    purchaserCredits[msg.sender] += _quantity;
    totalCreditsSold += _quantity;
		
    creditPurchases.push(CreditPurchase(msg.sender, _quantity, creditBasePrice, totalCost, now));
		
    bool overpaid = msg.value > totalCost;
    if (overpaid) {
      uint refund = msg.value - totalCost;
      if (!msg.sender.send(refund)) {
        revert();
      }
    }
		
    CreditPurchaseEvent(msg.sender, _quantity, creditBasePrice, totalCost);
  }
	
  function getRemainingCredits() public view returns (uint) {
    return purchaserCredits[msg.sender];
  }
	
  function updateCreditBasePrice(uint _creditBasePrice) public onlyOwner {
    creditBasePrice = _creditBasePrice;
  }
	
}