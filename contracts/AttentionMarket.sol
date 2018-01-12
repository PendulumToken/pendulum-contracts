pragma solidity ^0.4.18;

contract AttentionMarket {

  mapping(address => bytes32[]) senderToBookingKeyMap;
  mapping(address => bytes32[]) recipientToBookingKeyMap;
  mapping(bytes32 => Booking) bookingKeyToBookingMap;
  
  struct Booking {
    bytes32 bookingKey;
    address senderAddress;
    address recipientAddress;
    uint durationInMinutes;
    uint paidAmount;
    Status status;
  }
  
  enum Status {
    Invalid,
    Requested,
    Accepted,
    Rejected,
    Completed
  }
	
	function requestBooking(bytes32 _bookingKey, address _senderAddress, address _recipientAddress, uint _durationInMinutes, uint _paidAmount) public payable {
	  assert(bookingKeyToBookingMap[_bookingKey].status == Status.Invalid);
	  assert(_durationInMinutes > 0);
	  assert(_paidAmount >= 0);
	  assert(msg.value >= _paidAmount);
	  
    bookingKeyToBookingMap[_bookingKey] = Booking(_bookingKey, _senderAddress, _recipientAddress, _durationInMinutes, _paidAmount, Status.Requested);
    senderToBookingKeyMap[_senderAddress].push(_bookingKey);
    recipientToBookingKeyMap[_recipientAddress].push(_bookingKey);
    
    bool overpaid = msg.value > _paidAmount;
    if (overpaid) {
      uint refundAmount = msg.value - _paidAmount;
      msg.sender.transfer(refundAmount);
    }
  }
  
  function getBooking(bytes32 _bookingKey) public view returns (address senderAddress, address recipientAddress, uint durationInMinutes, uint paidAmount, Status status) {
    Booking storage booking = bookingKeyToBookingMap[_bookingKey];
    
    senderAddress = booking.senderAddress;
    recipientAddress = booking.recipientAddress;
    durationInMinutes = booking.durationInMinutes;
    paidAmount = booking.paidAmount;
    status = booking.status;
  }

  function acceptBooking(bytes32 _bookingKey) public {
    Booking storage booking = bookingKeyToBookingMap[_bookingKey];
    
    assert(msg.sender == booking.recipientAddress);
    assert(booking.status == Status.Requested);
    
    booking.status = Status.Accepted;
  }
  
  function rejectBooking(bytes32 _bookingKey) public payable {
    Booking storage booking = bookingKeyToBookingMap[_bookingKey];
    
    assert(msg.sender == booking.recipientAddress);
    assert(booking.status == Status.Requested || booking.status == Status.Accepted);
    
    booking.status = Status.Rejected;
    booking.senderAddress.transfer(booking.paidAmount);
  }
  
  function completeBooking(bytes32 _bookingKey) public payable {
    Booking storage booking = bookingKeyToBookingMap[_bookingKey];
    
    assert(msg.sender == booking.senderAddress);
    assert(booking.status == Status.Requested || booking.status == Status.Accepted);
    
    booking.status = Status.Completed;
    booking.recipientAddress.transfer(booking.paidAmount);
  }
  
  function getBookingKeysBySender(address senderAddress) public view returns (bytes32[]) {
    return senderToBookingKeyMap[senderAddress];
  }
  
  function getBookingKeysByRecipient(address recipientAddress) public view returns (bytes32[]) {
    return recipientToBookingKeyMap[recipientAddress];
  }
	
}