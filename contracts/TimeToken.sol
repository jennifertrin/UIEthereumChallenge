/// @title TimeToken Smart Contract
/// @author Jennifer Tran
/// @notice A smart contract that extends ERC20Mintable contract from Open Zeppelin and allows token transfer only between specific start and end times

pragma solidity ^0.5.0;

///@dev imports
///@notice ERC20Mintable from Open Zeppelin library
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol" as ERC20Mintable;

contract TimeToken is ERC20Mintable {
    uint256 private startTime;
    uint256 private endTime;

    constructor(uint _startTime, uint _endTime) public{
      _startTime = _startTime;
      _endTime = _endTime;
      address;
  }

    ///@notice function that allow  token transfer only between a start and end times
    ///@param _startTime is the start time of the donation window
    ///@param _endTime is the end time of the donation window
    ///@param _account is the address that the token is minted to
    ///@param value is the amount of the token minted
    ///@return returns the conversion from ETH to token, amount in the token
    function requiretime(uint256 _startTime, uint256 _endTime, address _account, uint value) public {
        uint256 _currenttime = now; ///@dev current time
        if (_currenttime >= _startTime && _currenttime <= _endTime) {
            mint(_account, value); ///@dev using the mint function from ERCMintable COntract
            _startTime = startTime;
            _endTime = endTime;
        }
        revert("The donation window is currently not open");
    }
}

