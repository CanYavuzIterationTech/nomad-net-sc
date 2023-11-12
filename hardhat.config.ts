import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    opbnb: {
      url: "https://opbnb-testnet-rpc.bnbchain.org/",
      accounts: [""]
    }
  }
};

export default config;
