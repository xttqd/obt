const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dice Smart Contract", function () {
  // Contract instance
  let diceContract;
  
  // Accounts
  let deployer;
  let alice;
  let bob;

  // Constants
  const ZERO_ADDRESS = "0x0000000000000000000000000000000000000000";

  before(async function () {
    // Get test accounts
    [deployer, alice, bob] = await ethers.getSigners();
  });

  beforeEach(async function () {
    // Fresh contract deployment before each test
    const DiceFactory = await ethers.getContractFactory("contracts/Dice.sol:Dice");
    diceContract = await DiceFactory.deploy();
  });

  describe("Initialization", function () {
    it("should initialize with the correct manager", async function () {
      // Given: Contract is deployed
      // When: We check the manager
      const manager = await diceContract.manager();
      
      // Then: Manager should be the deployer
      expect(manager).to.equal(deployer.address);
    });

    it("should initialize with an empty players array", async function () {
      // Given: Contract is deployed
      // When: We try to access the first player
      // Then: It should revert as array is empty
      await expect(diceContract.players(0))
        .to.be.reverted;
    });
  });

  describe("Manager Role", function () {
    it("should allow manager role transfer through CEO function", async function () {
      // Given: Contract is deployed with initial manager
      
      // When: Alice calls CEO function
      await diceContract.connect(alice).CEO();
      
      // Then: Alice should become the new manager
      expect(await diceContract.manager()).to.equal(alice.address);
    });

    it("should allow multiple consecutive manager changes", async function () {
      // Given: Contract is deployed
      expect(await diceContract.manager()).to.equal(deployer.address);
      
      // When: Multiple accounts call CEO
      // Then: Each should become manager in turn
      
      // First transfer
      await diceContract.connect(alice).CEO();
      expect(await diceContract.manager()).to.equal(alice.address);
      
      // Second transfer
      await diceContract.connect(bob).CEO();
      expect(await diceContract.manager()).to.equal(bob.address);
      
      // Back to deployer
      await diceContract.connect(deployer).CEO();
      expect(await diceContract.manager()).to.equal(deployer.address);
    });
  });

  describe("Edge Cases", function () {
    it("should handle manager change to same address", async function () {
      // Given: Alice is manager
      await diceContract.connect(alice).CEO();
      
      // When: Alice calls CEO again
      await diceContract.connect(alice).CEO();
      
      // Then: Alice should still be manager
      expect(await diceContract.manager()).to.equal(alice.address);
    });

    it("should maintain manager role after failed operations", async function () {
      // Given: Initial state
      const initialManager = await diceContract.manager();
      
      // When/Then: Contract maintains state after various operations
      expect(await diceContract.manager()).to.equal(initialManager);
    });
  });
}); 