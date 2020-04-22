pragma solidity ^0.6.0; 

//imports
import "./TimeToken.sol" as TimeToken; //TimeToken Contract
import "@openzeppelin/contracts/math/SafeMath.sol" as SafeMath;  //SafeMath Library from OpenZeppelin

contract Contribution is TimeToken {

    using SafeMath for uint256; //use SafeMath library

    address owner;

    //events
    //event to track new donation
    event NewDonation (
        address from,
        uint amount
    );

    //event to track requests to view balance
    event ViewBalance (
        uint balance,
        address balanceAddress
    );

    //event to track when contract token has been rewarded to donor
    event returnToken (
        uint tokenAmount,
        address from
    );

    //stores information of each donor
    struct Donor {
        uint date;
        address donorAddress;
        uint amount;
    }

    //associative array that stores address as a key and Donor as the value
    mapping (address => Donor) public donors;

    constructor () public {
        owner = msg.sender;
    }

    //fallback function to send Ether from address to this smart contract
    function donate() external payable {
        require(msg.value >= 0); //require donation to be more than 0 wei
        balances[owner].add(msg.value);
        emit NewDonation(owner, msg.value); //emit NewDonation event
    }

    //function that sends ERC20 automatically to donor
    function tokensend() payable public {
        TimeToken token token = TimeToken();
        token.transfer(msg.sender, 100);
        emit returnToken(msg.value, msg.sender); //emit returnToken event
    }

    //function that returns the donation amount of the address
    function checkDonation(address _address) public view returns(uint) {
        totalDonation = donors[_address];
        emit viewBalance(totalDonation, _address); //emit viewBalance event
        return totalDonation;
    }
}
