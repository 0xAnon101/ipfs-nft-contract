const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("AngelNFT");
  const nftContract = await nftContractFactory.deploy(
    "ipfs://QmVQfJmCnyobvJ5nYw4GYmKtFSceSYxHUWJccKDr1r1qff/"
  );
  await nftContract.deployed();

  console.log("nft_contract_instance", nftContract.address);

  let getBaseURI = await nftContract.baseURI();
  console.log("nft_base_uri", getBaseURI);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
