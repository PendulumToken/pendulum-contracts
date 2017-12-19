var AccountRegistry = artifacts.require("./registries/AccountRegistry.sol");

module.exports = function(deployer) {
  deployer.deploy(AccountRegistry);
};