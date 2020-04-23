/// @title Contribution Smart Contract
/// @author Jennifer Tran
/// @notice A smart contract that allows users to donate ETH to and provides tokens in return
pragma solidity ^0.6.0;

///@dev imports
import "./TimeToken.sol" as TimeToken; ///@dev TimeToken Contract
//import "@openzeppelin/contracts/math/SafeMath.sol" as SafeMath;  ///@dev SafeMath Library from OpenZeppelin

contract Contribution is TimeToken {

    using SafeMath for uint256; ///@dev use SafeMath library

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

    ///@dev token contract reference
    Token private contractReference;

`   ///@dev stores rate to convert ETH to token value
    uint ethToTokenRate;

    constructor (address _tokenReference) public {
        contractReference = Token(_tokenReference);
        ethToTokenRate = _ethToTokenRate;
    }

    ///@notice fallback function to send Ether from address to this smart contract and then automatically provides token from smart contract to donor
    ///@param amount is the amount donated
    function donate(uint amount) external payable {
        require(amount >= 0); ///@dev require donation to be more than 0 wei
        balances[msg.sender].add(amount); 
        emit NewDonation(msg.sender, amount); ///@dev emit NewDonation event
        ///@dev start of the automatic send of the smart contract token to the donor 
        uint tokenSend = convertETHtoToken(amount); ///@dev conversion from ETH to token using convertETHtoToken private function stored in contract
        contractReference.transfer(msg.sender, tokenSend); ///@dev transfer of token to donor
        emit returnToken(amount, msg.sender); ///@dev emit returnToken event
    }

    ///@notice private view function that converts ETH to token rate using mul function in Safe Math
    ///@param amount is the uint amount in ETH
    ///@return returns the conversion from ETH to token, amount in the token
    function convertETHtoToken(uint amount) private view returns(uint) {
        conversion = ethToTokenRate.mul(amount); ///@dev use of mul function in Safe Math library
        return conversion;
    }

    ///@notice public view function that returns the donation amount of the address
    ///@param address is the address that you would like to check
    ///@return returns the amount that the address has donated to this contract
    function checkDonation(address _address) public view returns(uint) {
        totalDonation = donors[_address];
        emit viewBalance(totalDonation, _address); ///@dev emit viewBalance event
        return totalDonation;
    }
}
