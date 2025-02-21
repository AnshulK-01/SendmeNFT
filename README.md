# SendmeNFT
SendmeNFT is a Solidity smart contract that enables users to mint and gift NFTs with personalized messages. This contract follows a simplified ERC-721-like structure without external dependencies, making it lightweight and easy to deploy.

Features 🚀
Mint NFTs with custom messages.
Gift NFTs to other addresses.
Track ownership of minted NFTs.
Retrieve messages attached to NFTs.
How It Works 🛠️
A user mints an NFT with a custom message.
The minted NFT is assigned to the sender.
The sender can transfer the NFT to another address.
The recipient can view the NFT and its associated message.
Smart Contract Overview 📝
Uses Solidity ^0.8.0.
Maintains an internal mapping of NFTs to owners and messages.
Emits events on minting and transferring NFTs.
Usage 📜
Deploy the contract, call mintNFT(message), and transfer NFTs using transferNFT(tokenId, recipient).

Future Enhancements 🔮
Integrate with a frontend for easy interaction.
Implement metadata and image support.
Expand functionality with ERC-721 standards.
