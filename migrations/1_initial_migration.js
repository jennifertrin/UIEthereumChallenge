const Migrations = artifacts.require("Migrations");
const Contributions = artifacts.require("Contribution");
const TimeToken = artifacts.require("TimeToken");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
module.exports = function(deployer) {
  deployer.deploy(Contribution);
};
module.exports = function(deployer) {
  deployer.deploy(TimeToken);
};

