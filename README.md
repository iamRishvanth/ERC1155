# Building ERC-1155 and Peform Minting ang SetTokenURI

## Build

### Smart Contract

To build the smart contract we would be using [Hardhat](https://hardhat.org/).
Hardhat is an Ethereum development environment and framework designed for full stack development. In simple words you can write your smart contract, deploy them, run tests, and debug your code.

To setup a Hardhat project, Open up a terminal and execute these commands

```bash
mkdir NFT-Tutorial
cd  NFT-Tutorial
npm init --yes
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
```

In the same directory where you installed Hardhat run:

```bash
npx hardhat
```

Select `Create a Javascript Project` and follow the steps. At the end, you will have a new Hardhat project ready to go!

---

## Write NFT Contract Code

Let's install some OpenZeppelin contracts so we can get access to the ERC-1155 contracts. In your terminal, execute the following command:

```
npm install @openzeppelin/contracts
```

- In the contracts folder, create a new Solidity file called ERC1155Token.sol
- Now we would write some code in the ERC1155Token.sol file. import [Openzeppelin's ERC1155 Contract](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol). ERC1155 is the most common standard for creating NFT's.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Import the openzepplin contracts
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
....
....
....
// you can see the Full solidity file in Repo
```

Compile the contract, open up a terminal and execute these commands

```bash
npx hardhat compile
```

## Configuring Deployment

Let's deploy the contract to `goerli` test network. To do this, we'll write a deployment script and then configure the network. First, create a new file/replace the default file named `deploy.js` under the `scripts` folder, and write the code for automate deployment process:

```js
// Import ethers from Hardhat package
const { ethers } = require("hardhat");
async function main() {
  /*
A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
so nftContract here is a factory for instances of our NFTee contract.
*/
  const nftContract = await ethers.getContractFactory("NFTee");
...
...
...
// you can full js file in repo
```

Now create a `.env` file for protect the private key and secure implementation

Use Infura, Quicknode, etc for API endpoint. After creating an account, `Create an endpoint` on Quicknode, select `Ethereum`, and then select the `Goerli` network. Click `Continue` in the bottom right and then click on `Create Endpoint`. Copy the link given to you in `HTTP Provider` and add it to the `.env` file below for `API_URL`

To get your private key, you need to export it from Metamask. Open Metamask, click on the three dots, click on `Account Details` and then `Export Private Key`. MAKE SURE YOU ARE USING A TEST ACCOUNT THAT DOES NOT HAVE MAINNET FUNDS FOR THIS. Add this Private Key below in your `.env` file for `PRIVATE_KEY` variable.

```
API_URL="add-quicknode-http-provider-url-here"
PRIVATE_KEY="add-the-private-key-here"
```

- Now we would install `dotenv` package to be able to import the env file and use it in our config.
  In your terminal, execute these commands.
  ```bash
  npm install dotenv
  ```
- Now open the hardhat.config.js file, we would add the `goerli` network here so that we can deploy our contract to the Goerli network. Replace all the lines in the `hardhat.config.js` file with the given below lines

```js
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
module.exports = {
  solidity: "0.8.9",
  networks: {
    goerli: {
      url: process.env.API_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
```

- To deploy in your terminal type:
  ```bash
      npx hardhat run scripts/deploy.js --network goerli
  ```
- Save the NFT Contract Address that was printed on your terminal in your notepad, you would need it.

## Verify on Etherscan

- Go to [Goerli Etherscan](https://goerli.etherscan.io/) and search for the address that was printed.
- If the `address` opens up on etherscan means the contact deployed successful..
