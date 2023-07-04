const hre = require("hardhat");

async function main() {
  const NftCollection = await hre.ethers.getContractFactory("NftCollection");
  const nftCollection = await NftCollection.deploy("contract", "cntr", process.env.BASE_URI);

  const address = await nftCollection.getAddress();
  console.log(`Contract Address: ${address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});