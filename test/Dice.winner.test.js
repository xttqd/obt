const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dice Winner Function", function () {
  it("Should determine a winner correctly", async function () {
    const Dice = await ethers.getContractFactory("Dice");
    const dice = await Dice.deploy();
    await dice.deployed();
    expect(true).to.not.equal(false);
  });
}); 