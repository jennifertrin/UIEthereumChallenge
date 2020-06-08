const {
    BN,
    constants,
    time,    // Common constants, like the zero address and largest integers
    expectEvent,  // Assertions for emitted events
    expectRevert, // Assertions for transactions that should fail
  } = require('@openzeppelin/test-helpers');

const chai = require('chai');
chai
  .should();

const TimeToken = artifacts.require('TimeToken'); //test for TimeToken contract
// const Contribution = artifacts.require('Contribution'); //test for Contribution contract

//create variables used in the functions in the TimeToken and Contribution contracts

//create variables for start and end times

// var today = new Date(); 
// var now = today.getTime(); // stores current time in milliseconds since epoch

let amount = 10; //donation amount
let ethToTokenRate = 8; //ETH to token conversion rate


/* These tests will account for the following three events:
1. When the current time is within the start and end times, a donation will be made. 
2. When a donation is made, the equivalent amount in tokens is automatically sent to the donor.
3. When a donation is made, confirm that you can view the amount donated from the address.
4. When the current time is not within the start and end times, a donation cannot be made and an error will be displayed. No tokens will be sent to the address that attempted to donate. 
*/
contract('TimeToken', function (accounts) {
    
    let firstAccount = accounts[0]; //first test account from Ganache
    console.log('hihi')
    beforeEach(async function () { //use beforeEach to set up calls that need to happen before each test
        console.log('hello')
        let startTime = await time.increase(time.duration.minutes(5));
        let endTime = await startTime.increase(time.duration.week(2));
    
        const tokenInstance = await TimeToken.new(startTime, endTime);
        console.log(startTime);
        console.log(endTime);
        console.log(tokenInstance);
    });
    // beforeEach(async () => { //use beforeEach to set up calls that need to happen before each test
    //     let c = await Contribution.new(t.address,ethToTokenRate);
    // });
    // //tests that confirm the flow when a donation is made within the start and end time frames
    // it('Confirms that a donation was made by checking that first event called NewDonation was logged', async() => {
    //     const time = await TimeToken.new(_startTime, _endTime);
    //     const result = await c.donate(amount);
    //     assert.equal(result.logs[0].event, 'NewDonation');
    // });
    // it('Confirms that the token transfer was made by checking that the the second event called returnToken was logged', async() => {
    //     const time = await TimeToken.new(_startTime, _endTime);
    //     const result = await c.donate(amount);
    //     assert.equal(result.logs[1].event, 'returnToken');
    // });
    // it('Confirms that the amount of the donation is equal to the donation amount is logged to a specific address', async() => {
    //     const time = await TimeToken.new(_startTime, _endTime);      
    //     const result = await c.checkDonation(firstAccount);
    //     assert.equal(result, amount);
    // });
    // //test that confirms an error when attempt to donate outside of start and end times
    // it('Confirms that cannot proceed if current time is not within the start and end times', async() => {
    //     const time = await TimeToken.new();      
    //     const result = await time.requiretime(_startTime + 4000, _endTime - 4000, firstAccount, amount);
    //     assert.equal(result, "The donation window is currently not open");
    // });
});
