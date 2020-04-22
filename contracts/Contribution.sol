/// @title Contribution Smart Contract
/// @author Jennifer Tran
/// @notice A smart contract that allows users to donate ETH to and provides tokens in return
pragma solidity ^0.6.0; 

///@dev imports
import "./TimeToken.sol" as TimeToken; ///@dev TimeToken Contract
import "@openzeppelin/contracts/math/SafeMath.sol" as SafeMath;  ///@dev SafeMath Library from OpenZeppelin

contract Contribution is TimeToken {

    using SafeMath for uint256; ///@dev use SafeMath library

    address owner;

    ///@dev events
    ///@dev event to track new donation
    event NewDonation (
        address from,
        uint amount
    );

    ///@dev event to track requests to view balance
    event ViewBalance (
        uint balance,
        address balanceAddress
    );

    ///@dev event to track when contract token has been rewarded to donor
    event returnToken (
        uint tokenAmount,
        address from
    );

    ///@dev stores information of each donor
    struct Donor {
        uint date;
        address donorAddress;
        uint amount;
    }

    ///@dev associative array that stores address as a key and Donor as the value
    mapping (address => Donor) public donors;

    ///@dev token contract reference to avoid hard coding
    Token private contractReference;

    constructor (address _tokenReference) public {
        contractReference = Token(_tokenReference);
    }

    ///@notice fallback function to send Ether from address to this smart contract
    ///@param amount is the amount donated
    function donate(uint amount) external payable {
        require(amount >= 0); ///@dev require donation to be more than 0 wei
        balances[msg.sender].add(amount);
        emit NewDonation(msg.sender, amount); ///@dev emit NewDonation event
        TimeToken token token = TimeToken();
        contractReference.transfer(msg.sender, amount);
        emit returnToken(msg.value, msg.sender); ///@dev emit returnToken event
    }

    ///@notice function that returns the donation amount of the address
    ///@param address is the address that you would like to check
    ///@return returns the amount that the address has donated to this contract
    function checkDonation(address _address) public view returns(uint) {
        totalDonation = donors[_address];
        emit viewBalance(totalDonation, _address); ///@dev emit viewBalance event
        return totalDonation;
    }
}
