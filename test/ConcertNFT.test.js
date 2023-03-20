const { expect } = require("chai");
const ConcertNFT = artifacts.require("ConcertNFT");

contract("ConcertNFT", (accounts) => {
  let contract;

  before(async () => {
    contract = await ConcertNFT.new();
    // Créer les concerts ici si nécessaire
  });

  describe("createConcert", () => {
    it("should create new Concert NFTs", async () => {
      // Create multiple concerts
      await contract.createConcert(
        "Bob Dylan",
        "Madison Square Garden",
        1649452800, // 07-04-2023 12:00:00
        web3.utils.toWei("1", "ether")
      );
      await contract.createConcert(
        "The Rolling Stones",
        "Staples Center",
        1649366400, // 06-04-2023 12:00:00
        web3.utils.toWei("2", "ether")
      );
      await contract.createConcert(
        "Elton John",
        "The O2",
        1649377200, // 06-04-2023 15:00:00
        web3.utils.toWei("3", "ether")
      );
    });
  });

//   describe("showConcerts", () => {
//     it("should show all Concert NFTs", async () => {
//       // Get the total number of concerts
//       const totalConcerts = await contract.totalConcerts();

//       // Log the name of each concert
//       for (let i = 0; i < totalConcerts; i++) {
//         const concert = await contract.concerts(i);
//         console.log(`Concert ${i}: ${concert.artist} - ${concert.location}`);
//       }

//       // Verify the total number of concerts
//       expect(totalConcerts.toNumber()).to.equal(3);
//     });
//   });
});
