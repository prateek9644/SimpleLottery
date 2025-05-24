const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying SimpleLottery contract with account:", deployer.address);

  const SimpleLottery = await hre.ethers.getContractFactory("SimpleLottery");
  const simpleLottery = await SimpleLottery.deploy();

  await simpleLottery.deployed();

  console.log("SimpleLottery deployed to:", simpleLottery.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
