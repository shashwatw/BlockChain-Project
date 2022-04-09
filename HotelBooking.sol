pragma solidity ^0.6.0;

contract HotelRooms {

    //vacant
    //occupied
    //for this use enum
    enum Status { Vacant, Occupied }
    Status currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    constructor() public {
        owner = msg.sender;
        currentStatus = Status.Vacant;
    }


    modifier onlyWhileVacant {
        require(currentStatus == Status.Vacant, "Currently Occupied!");
        _;
    }

    modifier costs (uint _amount) {
        require(msg.value >= _amount, "Not enough Ether provided");
        _;
    }

    receive() external payable onlyWhileVacant costs(2 ether) {
        //Check price
        // require(msg.value >= 2 ether, "Not enough Ether provided!") 
        //check status
        // require(currentStatus == Status.Vacant, "Currently Occupied!");
        currentStatus = Status.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);

    }

}
