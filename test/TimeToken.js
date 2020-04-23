const TimeToken = artifacts.require('TimeToken'); //test for TimeToken contract
const Contribution = artifacts.require('Contribution'); //test for Contribution contract

//create variables used in the functions in the TimeToken and Contribution contracts

//create variables for start and end times
var today = new Date(); 
var now = today.getTime(); //stores current time in milliseconds since epoch
var _startTime = now - 2000;
var _endTime = now + 4000;

var amount = 10; //donation amount
var ethToTokenRate = 8; //ETH to token conversion rate

contract('DonationTests', () => {
})