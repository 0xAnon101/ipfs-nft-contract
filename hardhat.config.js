require("dotenv").config();

require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
require("solidity-coverage");

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: process.env.ALCHEMY_TESTNET_API_URL,
      accounts: [process.env.RINKEBY_PRIVATE_KEY],
    },
    polygon: {
      url: process.env.ALCHEMY_TESTNET_API_URL_POLY,
      accounts: [process.env.RINKEBY_PRIVATE_KEY],
    },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.MAINNET_POLYGONSCAN_KEY,
  },
};
