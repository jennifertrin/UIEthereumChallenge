const {
    time,
  } = require('@openzeppelin/test-helpers');

const chai = require('chai');
chai
  .should();

const TimeToken = artifacts.require('TimeToken'); //test for TimeToken contract

contract('TimeToken', function (accounts) {

    beforeEach(async () =>  { //use beforeEach to set up calls that need to happen before each test
        let startTime = (await time.latest()).add(time.duration.minutes(1));
        startTime = startTime.toNumber(); 

        let endTime = (await time.latest()).add(time.duration.weeks(1));
        endTime = endTime.toNumber();

        this.tokenInstance = await TimeToken.new(startTime, endTime);
        
        // console.log(tokenInstance);
    });
    describe('constructor', function () {
        it('should set startTime', async function () {
           
        });
        it('should set endTime', async function () {
           
        });
        it('should set caller to Minter Role', async function () {
           
        });
        it('should mint 1000 tokens in TimeToken contract', async function () {
           
        });
    });


});
