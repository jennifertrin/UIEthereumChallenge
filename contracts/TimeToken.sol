/// @title A smart contract that extends ERC20Mintable contract from Open Zeppelin and allows token transfer only between specific start and end times
/// @author Jennifer Tran
/// @notice You can use this contract for only the most basic simulation
/// @dev All function calls are currently implemented without side effects

pragma solidity ^0.6.0; 

//imports
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol" as ERC20Mintable; //ERC20Mintable from Open Zeppelin library

contract TimeToken is ERC20Mintable {
    uint256 starttime;
    uint256 endtime;
    
    //function that allow token transfer only between a start and end times
    function requiretime(uint256 _starttime, uint256 _endtime) public view {
        uint256 _currenttime = now; //current time
        require(_currenttime >= _starttime); //require current time is after or equal to start time
        require(_currenttime <= _endtime); //require current time is before or equal to end time

        _starttime = starttime;
        _endtime = endtime;
    }
    
    //function that checks if the current time is between the start and end times
    function checktime() public view returns(bool isCheck) {
        bool isAfterStart = (now >= starttime); //checks that current time is after or equal to start time
        bool isBeforeEnd = (now <= endtime); //checks that current time is before or equal to end time
        bool isWithinTimeframe = isAfterStart && isBeforeEnd; //checks both conditions are met
        return isWithinTimeframe;
    }
}

