const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dice Contract Deployment", function () {
  it("Should deploy the contract successfully", async function () {
    const Dice = await ethers.getContractFactory("Dice");
    const dice = await Dice.deploy();
    await dice.deployed();
    expect(true).to.equal(true);
  });
}); 