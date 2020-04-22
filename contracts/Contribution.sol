pragma solidity ^0.5.0; 

//imports
import "../TimeToken.sol" //TimeToken Contract
import "@OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol" //SafeMath Library from OpenZeppelin

contract Contribution is TimeToken {

    using SafeMath for uint256; //call SafeMath library

    //events
    //event to track new donation
    event NewDonation {
        uint date,
        address from,
        address to,
        uint amount
    }

    //event to track requests to view balance
    event ViewBalance {
        uint balance,
        address balanceAddress
    }

    //event to track when contract token has been rewarded to donor
    event returnToken {
        uint tokenAmount,
        address from
    }

    //function to emit the NewDonation event
    function donation(address to, uint amount) external {
        emit NewDonation(now, msg.sender, to, amount);
    }
}
