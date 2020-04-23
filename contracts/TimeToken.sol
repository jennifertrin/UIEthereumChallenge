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
    
    ///@notice function that allows token transfer only between a start and end times
    ///@param _starttime is the start time of the donation window
    ///@param _sendtime is the end time of the donation window
    ///@param address is the address that the token is minted to
    ///@param value is the amount of the token minted
    ///@return returns the conversion from ETH to token, amount in the token
    function requiretime(uint256 _starttime, uint256 _endtime, address _account, uint value) public view {
        uint256 _currenttime = now; ///@dev current time
        if (_currenttime >= _starttime && _currenttime <= _starttime) {
            mint(_account, value); ///@dev using the mint function from ERCMintable Contract
            _starttime = starttime;
            _endtime = endtime;
        }
        revert("The donation window is currently not open");
    }
}

