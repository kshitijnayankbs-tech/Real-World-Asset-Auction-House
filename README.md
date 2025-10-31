Real-World Asset Auction House

A decentralized auction platform for tokenized real-world assets (RWAs) such as real estate, art, collectibles, and commodities. This project aims to facilitate transparent, secure, and permissionless auctions on the blockchain using smart contracts written in Solidity.

<--Features-->

Tokenization of real-world assets

Timed and reserve-price auctions

Bidding with automatic highest-bid tracking

Escrow and asset transfer mechanisms

Auction settlement and ownership transfer

Audit-friendly event logging

| Layer              | Tech / Tool                 |
| ------------------ | --------------------------- |
| Smart Contracts    | Solidity                    |
| Blockchain         | Ethereum / EVM chain        | 
| Development        | Hardhat / Truffle           | 
| Token Standard     | ERC-721 or ERC-1155         |
| Wallets            | MetaMask, WalletConnect     |
| Frontend           | React + Ethers.js / Web3.js |
| Storage (optional) | IPFS, NFT.Storage           |
| Testing            | Chai, Mocha (via Hardhat)   |
| Linting            | Solhint, Prettier           |
| Deployment         | Alchemy / Infura + Hardhat  |

<--Smart Contract Modules-->

AuctionFactory.sol

Deploys and manages multiple auctions

Auction.sol

Handles a single asset auction (bidding, timers, settlement)

AssetToken.sol (optional)

Token contract if you choose to tokenize assets yourself

Escrow.sol (optional)

Holds funds and tokens during auction process

<img width="2559" height="1196" alt="image" src="https://github.com/user-attachments/assets/4bbcf5d0-e769-47bc-af3a-99846d5a81e5" />

0xdd218d6e45BB003FB928Acdf13B63d021dF73B58
