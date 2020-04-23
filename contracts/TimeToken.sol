/// @title TimeToken Smart Contract
/// @author Jennifer Tran
/// @notice A smart contract that extends ERC20Mintable contract from Open Zeppelin and allows token transfer only between specific start and end times

pragma solidity ^0.6.0;

///@dev imports
///@notice ERC20Mintable from Open Zeppelin library
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol" as ERC20Mintable; 

contract TimeToken is ERC20Mintable {
    uint256 private starttime;
    uint256 private endtime;
    
    ///@notice function that allow token transfer only between a start and end times
    function requiretime(uint256 _starttime, uint256 _endtime) public view {
        uint256 _currenttime = now; //current time
        require(_currenttime >= _starttime); ///@dev require current time is after or equal to start time
        require(_currenttime <= _endtime); ///@dev require current time is before or equal to end time
        _starttime = starttime;
        _endtime = endtime;
    }
}

