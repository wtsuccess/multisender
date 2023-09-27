import { ethers } from "hardhat";
import { MultiSender, MultiSender__factory } from "../../typechain-types";

async function main() {
  const MultiSenderFactory: MultiSender__factory =
    await ethers.getContractFactory("MultiSender");
  const multiSender: MultiSender = await MultiSenderFactory.deploy();
  await multiSender.deployed();
  console.log("multiSender address", multiSender.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
