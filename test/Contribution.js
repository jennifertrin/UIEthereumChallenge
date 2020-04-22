const TimeToken = artifacts.require('Contribution'); //test for Contribution contract

contract('Contribution', () => {
    //first test
    it('Should return true if start time is before and end time is after the current time', async () => {
        const contractInstance = await Contribution.new();
        await Contribution.send({from: accounts[0], value: 10});
    });