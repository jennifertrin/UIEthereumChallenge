/// @title Contribution Smart Contract
/// @author Jennifer Tran
/// @notice A smart contract that allows users to donate ETH to and provides tokens in return
pragma solidity ^0.6.0; 

///@notice imports
import "./TimeToken.sol" as TimeToken; ///@dev TimeToken Contract
import "@openzeppelin/contracts/math/SafeMath.sol" as SafeMath;  ///@dev SafeMath Library from OpenZeppelin

contract Contribution is TimeToken {

    using SafeMath for uint256; ///@dev use SafeMath library

    address owner;

    ///@notice events
    ///@notice event to track new donation
    event NewDonation (
        address from,
        uint amount
    );

    ///@notice event to track requests to view balance
    event ViewBalance (
        uint balance,
        address balanceAddress
    );

    ///@notice event to track when contract token has been rewarded to donor
    event returnToken (
        uint tokenAmount,
        address from
    );

    ///@notice stores information of each donor
    struct Donor {
        uint date;
        address donorAddress;
        uint amount;
    }

    ///@notice associative array that stores address as a key and Donor as the value
    mapping (address => Donor) public donors;

    constructor () public {
        owner = msg.sender;
    }

    ///@notice fallback function to send Ether from address to this smart contract
    function donate() external payable {
        require(msg.value >= 0); ///@dev require donation to be more than 0 wei
        balances[owner].add(msg.value);
        emit NewDonation(owner, msg.value); ///@dev emit NewDonation event
    }

    ///@notice function that sends ERC20 automatically to donor
    function tokensend() payable public {
        TimeToken token token = TimeToken();
        token.transfer(msg.sender, 100);
        emit returnToken(msg.value, msg.sender); ///@dev emit returnToken event
    }

    ///@notice function that returns the donation amount of the address
    function checkDonation(address _address) public view returns(uint) {
        totalDonation = donors[_address];
        emit viewBalance(totalDonation, _address); ///@dev emit viewBalance event
        return totalDonation;
    }
}
