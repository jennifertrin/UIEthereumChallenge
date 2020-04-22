const TimeToken = artifacts.require('TimeToken'); //test for TimeToken contract
//create variables to store current time
var today = new Date(); 
var now = today.getTime(); //stores current time in milliseconds since epoch

contract('TimeToken', () => {
    //first test
    it('Should return true if start time is before and end time is after the current time', async () => {
        const contractInstance = await TimeToken.new();
        var starttime = now - 200; 
        var endtime = now + 200;
        const result = await contractInstance.checktime();
        assert(result == true); 
    });
    //second test
    it('Should return false if start time is after the current time', async () => {
        const contractInstance = await TimeToken.new();
        var starttime = now + 200;
        var endtime = now + 400;
        const result = await contractInstance.checktime();
        assert(result == false);
    });
    //third test
    it('Should return false if end time is before the current time', async () => {
        const contractInstance = await TimeToken.new();
        var starttime = now - 600;
        var endtime = now - 400;
        const result = await contractInstance.checktime();
        assert(result == false);
    });
})