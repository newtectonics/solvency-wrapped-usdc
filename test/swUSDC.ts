import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Test swUSDC", function () {

  async function deployswUSDC() {
    const [deployer, otherAccount] = await ethers.getSigners();

    const SolvencyWrappedUSDC = await ethers.getContractFactory(
      "SolvencyWrappedUSDC"
    );
    
    const swUSDC = await SolvencyWrappedUSDC.deploy();

    const governor = await swUSDC.governor();
    const vswUSDC = await swUSDC.vswUSDC();

    return { swUSDC, deployer, governor, vswUSDC };
  }

  describe("Deployment", function () {
    it("Should set the right thresholdMet and locked on init", async function () {
      const { swUSDC } = await loadFixture(deployswUSDC);

      expect(await swUSDC.thresholdMet()).to.equal(false);
      expect(await swUSDC.locked()).to.equal(false);
    });

    it("Should set the right owner", async function () {
      const { swUSDC, deployer, governor } = await loadFixture(deployswUSDC);
      expect(deployer.address).to.not.equal(governor);
      expect(await swUSDC.owner()).to.equal(governor);
    });
  });
