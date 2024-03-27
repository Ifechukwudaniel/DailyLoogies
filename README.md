# Daily Loogie

Video Link https://www.loom.com/share/5b5187290e264202a7f45c99c403a748?sid=dd84146e-bdb1-4c38-97ad-1ce66ef31c6e

Daily Loogie is a platform where a Single random Loogie NFT is available for auction every day. Interested parties can participate by placing their bids on the NFT and at the end of the day, the NFT is awarded to the highest bidder. The process repeats daily, and a chance for users to acquire unique Loogie NFTs. Additionally, Users are allowed to vote for the design of the next Loogie from a selection of four randomly chosen NFTs.

## How it's Made

DailyLoogie is built using **Scaffold-ETH** and The Graph protocol. The graphprotol is usedto efficiently access and query data from the Ethereum smart contracts. The core components of the project's smart contracts include:

- **Loogie.sol**: This contract is responsible for creating the SVG-based NFTs representing Loogies and mint.
- **Loogie Auction**: Handles the auction functionality, enabling users to bid on Loogie NFTs.
- **Loogie Voting**: Vote for Next Loogie.

## Features of the App

- **Bid for NFTs**: Users can place bids on the daily auctioned Loogie NFT.
- **Refund System**: Users receive refunds for their bids if they are not the highest bidder for a particular auction at.

## Challenges Faced

**1. Randomization in Solidity**: Implementing reliable and unpredictable randomness for selecting the NFTs to be auctioned and voted on presented a significant challenge. Ensuring fairness and unpredictability in the selection process required innovative solutions.

**2. Time Constraints**: Developing a functional and user-friendly platform within the timeframe of the hackathon posed its own set of challenges. Prioritizing features and optimizing development workflows were essential to meeting project deadlines.

## Future Developments

The Daily Loogie platform aims to continuously evolve and improve its features. Future developments may include enhancements to the auction mechanics, further community engagement features, and optimizations for scalability and user experience. Stay tuned for exciting updates and new opportunities to engage with the Daily Loogie community!

## Dedication

Daily loogie was inspired by Nouns and OptimistLoogies. My aim was to create an Auction system for Optimist Loogies

## Requirements

Before you begin, you need to install the following tools:

- [Node (>= v18.17)](https://nodejs.org/en/download/)
- Yarn ([v1](https://classic.yarnpkg.com/en/docs/install/) or [v2+](https://yarnpkg.com/getting-started/install))
- [Git](https://git-scm.com/downloads)

## Quickstart

To get started with Scaffold-ETH 2, follow the steps below:

1. Clone this repo & install dependencies

```
git clone https://github.com/scaffold-eth/scaffold-eth-2.git
cd scaffold-eth-2
yarn install
```

2. Run a local network in the first terminal:

```
yarn chain
```

This command starts a local Ethereum network using Hardhat. The network runs on your local machine and can be used for testing and development. You can customize the network configuration in `hardhat.config.ts`.

3. On a second terminal, deploy the test contract:

```
yarn deploy
```

This command deploys a test smart contract to the local network. The contract is located in `packages/hardhat/contracts` and can be modified to suit your needs. The `yarn deploy` command uses the deploy script located in `packages/hardhat/deploy` to deploy the contract to the network. You can also customize the deploy script.

4. On a third terminal, start your NextJS app:

```
yarn start
```

Visit your app on: `http://localhost:3000`. You can interact with your smart contract using the `Debug Contracts` page. You can tweak the app config in `packages/nextjs/scaffold.config.ts`.

Run smart contract test with `yarn hardhat:test`

- Edit your smart contract `YourContract.sol` in `packages/hardhat/contracts`
- Edit your frontend in `packages/nextjs/pages`
- Edit your deployment scripts in `packages/hardhat/deploy`

## Documentation

Visit our [docs](https://docs.scaffoldeth.io) to learn how to start building with Scaffold-ETH 2.

To know more about its features, check out our [website](https://scaffoldeth.io).

## Contributing to Scaffold-ETH 2

We welcome contributions to Scaffold-ETH 2!

Please see [CONTRIBUTING.MD](https://github.com/scaffold-eth/scaffold-eth-2/blob/main/CONTRIBUTING.md) for more information and guidelines for contributing to Scaffold-ETH 2.
