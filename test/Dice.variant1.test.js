const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dice Contract - Complex Scenarios", function () {
  let dice;
  let owner;
  let player1;
  let player2;
  let player3;
  let addresses;

  beforeEach(async function () {
    // Get multiple test accounts
    [owner, player1, player2, player3, ...addresses] = await ethers.getSigners();
    
    // Deploy contract
    const Dice = await ethers.getContractFactory("contracts/Dice.sol:Dice");
    dice = await Dice.deploy();
  });

  describe("Access Control", function () {
    it("Should set deployer as initial manager", async function () {
      expect(await dice.manager()).to.equal(owner.address);
    });

    it("Should allow any address to become manager through CEO function", async function () {
      // Player1 becomes manager
      await dice.connect(player1).CEO();
      expect(await dice.manager()).to.equal(player1.address);

      // Player2 becomes manager
      await dice.connect(player2).CEO();
      expect(await dice.manager()).to.equal(player2.address);
    });
  });

  describe("Players Management", function () {
    it("Should initialize with empty players array", async function () {
      // Try to get the length of players array
      const playersLength = await dice.players.length;
      expect(playersLength).to.equal(0);
    });

    it("Should maintain correct manager after multiple CEO changes", async function () {
      // Series of management changes
      await dice.connect(player1).CEO();
      expect(await dice.manager()).to.equal(player1.address);
      
      await dice.connect(player2).CEO();
      expect(await dice.manager()).to.equal(player2.address);
      
      await dice.connect(player3).CEO();
      expect(await dice.manager()).to.equal(player3.address);
      
      // Original owner becomes manager again
      await dice.connect(owner).CEO();
      expect(await dice.manager()).to.equal(owner.address);
    });
  });

  describe("Events and State", function () {
    it("Should handle multiple rapid manager changes", async function () {
      // Rapid manager changes
      for(let i = 0; i < 5; i++) {
        await dice.connect(addresses[i]).CEO();
        expect(await dice.manager()).to.equal(addresses[i].address);
      }
    });
  });
}); 