pragma solidity ^0.5.0; 

//imports
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol"; //ERC20Mintable from Open Zeppelin library

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

