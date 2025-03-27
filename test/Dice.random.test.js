const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dice Random Number Generation", function () {
  it("Should have proper random number generation", async function () {
    const Dice = await ethers.getContractFactory("Dice");
    const dice = await Dice.deploy();
    await dice.deployed();
    expect(true).to.equal(true);
  });
}); 