// const ConcertNFT = artifacts.require("ConcertNFT");
const Concert = artifacts.require("Concert");

module.exports = function (deployer) {
//   deployer.deploy(ConcertNFT);
  deployer.deploy(Concert);
};
