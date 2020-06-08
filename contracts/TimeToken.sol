pragma solidity ^0.6.0;

///@dev imports
///@notice ERC20Mintable from Open Zeppelin library
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract TimeToken is ERC20, AccessControl {
    uint256 public startTime;
    uint256 public endTime;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(uint256 _startTime, uint256 _endTime)
        ERC20('TimeToken', 'TT')
        public
    {
        require(_startTime > now && _startTime < _endTime,
        'StartTime must be greater than now'
        );
      _startTime = _startTime;
      _endTime = _endTime;

      _setupRole(MINTER_ROLE, msg.sender);
      mint(address(this), 1000);
    }

    function mint(address to, uint256 amount) public {
        // Check that the calling account has the minter role
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _mint(to, amount);
    }

    ///@notice function that allow  token transfer only between a start and end times
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        uint256 currentTime = now;
        require(currentTime >= startTime && currentTime <= endTime,
            'The donation window is currently not open'
        );
        require(super.transfer(recipient, amount));
    }

}

