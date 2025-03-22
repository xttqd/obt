const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dice", function () {
  let Dice;
  let dice;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    Dice = await ethers.getContractFactory("Dice");
    dice = await Dice.deploy();
  });

  describe("Deployment", function () {
    it("Should set the right manager", async function () {
      expect(await dice.manager()).to.equal(owner.address);
    });
  });

  describe("CEO", function () {
    it("Should allow changing manager", async function () {
      await dice.CEO();
      expect(await dice.manager()).to.equal(owner.address);
    });
  });
}); 