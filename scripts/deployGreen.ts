import { formatEther, parseEther } from "viem";
import hre from "hardhat";

async function main() {


  const greenTracker = await hre.viem.deployContract("GreenTracker", [], {
   
  });

  console.log(
    `GreenTracker deployed to ${greenTracker.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
