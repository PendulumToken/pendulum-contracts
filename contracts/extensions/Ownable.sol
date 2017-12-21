pragma solidity ^0.4.18;

contract Ownable {
	
  address internal owner;

  function Ownable() public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function getOwner() public view returns (address) {
    return owner;
  }

  function transferOwnership(address _newOwner) public onlyOwner returns (bool) {
    if (_newOwner != address(0)) {
      owner = _newOwner;
    }
		
    return true;
	}
}
