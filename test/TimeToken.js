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
let firstAccount = accounts[0]; //first test account from Ganache

/* These tests will account for the following three events:
1. When the current time is within the start and end times, a donation will be made. 
2. When a donation is made, the equivalent amount in tokens is automatically sent to the donor.
3. When a donation is made, confirm that you can view the amount donated from the address.
4. When the current time is not within the start and end times, a donation cannot be made and an error will be displayed. No tokens will be sent to the address that attempted to donate. 
*/
contract('DonationTests', async () => {
    beforeEach(async () => { //use beforeEach to set up calls that need to happen before each test
        let c = await Contribution.new(t.address,ethToTokenRate);
    });
    //tests that confirm the flow when a donation is made within the start and end time frames
    it('Confirms that a donation was made by checking that first event called NewDonation was logged', async() => {
        const time = await TimeToken.new(_startTime, _endTime);
        const result = await c.donate(amount);
        assert.equal(result.logs[0].event, 'NewDonation');
    });
    it('Confirms that the token transfer was made by checking that the the second event called returnToken was logged', async() => {
        const time = await TimeToken.new(_startTime, _endTime);
        const result = await c.donate(amount);
        assert.equal(result.logs[1].event, 'returnToken');
    });
    it('Confirms that the amount of the donation is equal to the donation amount is logged to a specific address', async() => {
        const time = await TimeToken.new(_startTime, _endTime);      
        const result = await c.checkDonation(firstAccount);
        assert.equal(result, amount);
    });
    //test that confirms an error when attempt to donate outside of start and end times
    it('Confirms that cannot proceed if current time is not within the start and end times', async() => {
        const time = await TimeToken.new(_startTime + 4000, _endTime - 4000);      
        const result = await time.requiretime();
        assert.equal(result, false);
    });
});