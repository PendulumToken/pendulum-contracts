pragma solidity ^0.4.18;

contract AttentionMarket {

  mapping(address => bytes32[]) senderToBookingKeyMap;
  mapping(address => bytes32[]) recipientToBookingKeyMap;
  mapping(bytes32 => Booking) bookingKeyToBookingMap;
  
  struct Booking {
    bytes32 bookingKey;
    address senderAddress;
    address recipientAddress;
    uint32 durationInMinutes;
    uint32 paidAmount;
    Status status;
  }
  
  enum Status {
    Requested,
    Accepted,
    Rejected,
    Completed
  }
	
	function requestBooking(bytes32 _bookingKey, address _senderAddress, address _recipientAddress, uint32 _durationInMinutes, uint32 _paidAmount) public {
    bookingKeyToBookingMap[_bookingKey] = Booking(_bookingKey, _senderAddress, _recipientAddress, _durationInMinutes, _paidAmount, Status.Requested);
    senderToBookingKeyMap[_senderAddress].push(_bookingKey);
    recipientToBookingKeyMap[_recipientAddress].push(_bookingKey);
  }
  
  function getBooking(bytes32 _bookingKey) public view returns (address senderAddress, address recipientAddress, uint32 durationInMinutes, uint32 paidAmount, Status status) {
    Booking storage booking = bookingKeyToBookingMap[_bookingKey];
    senderAddress = booking.senderAddress;
    recipientAddress = booking.recipientAddress;
    durationInMinutes = booking.durationInMinutes;
    paidAmount = booking.paidAmount;
    status = booking.status;
  }

  function acceptBooking(bytes32 _bookingKey) public {
    Booking storage booking = bookingKeyToBookingMap[_bookingKey];
    booking.status = Status.Accepted;
  }
  
  function rejectBooking(bytes32 _bookingKey) public {
    Booking storage booking = bookingKeyToBookingMap[_bookingKey];
    booking.status = Status.Rejected;
  }
  
  function completeBooking(bytes32 _bookingKey) public {
    Booking storage booking = bookingKeyToBookingMap[_bookingKey];
    booking.status = Status.Completed;
  }
	
}