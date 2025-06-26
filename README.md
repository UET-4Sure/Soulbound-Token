# Identity SoulBound Token (SBT)

## Introduction

This project implements a non-transferable ERC-721 token (SoulBound Token) designed for identity verification for **Vinaswap DEX**. Built with Foundry, a blazing fast and modular toolkit for Ethereum application development written in Rust, this SBT serves as a digital passport or identity verification system.

## What is a SoulBound Token?

SoulBound Tokens (SBTs) are non-transferable NFTs that represent a user's identity, credentials, or affiliations. Unlike traditional NFTs, SBTs cannot be transferred between wallets once minted, making them perfect for identity verification and credential systems.

## Key Features

- **Non-transferable NFTs**: Once minted to a wallet, the token cannot be transferred to another address
- **One Token Per Address**: Each wallet can only hold one identity token
- **Controlled Minting**: Only the contract owner can mint new tokens
- **Revocable**: The contract owner can burn tokens if needed (e.g., in cases of compromised identities)
- **Identity Verification**: Each token serves as a passport for accessing services
- **Metadata Support**: Each token can store unique identity information through URI storage

## Technical Implementation

### Smart Contract Architecture

The project is built on OpenZeppelin's battle-tested contracts with custom modifications:

- Base: `ERC721URIStorage` for metadata management
- Access Control: `Ownable` for controlled minting and burning
- Custom Features:
  - Transfer blocking mechanism
  - Single token per address enforcement
  - Token ID tracking system
  - Address to token mapping

### Key Functions

```solidity
function mint(address to, string memory uri) external onlyOwner
function burn(address from) external onlyOwner
function hasToken(address user) public view returns (bool)
```

### Security Features

- Transfer functions are blocked through custom `_update` override
- Approval functions are disabled to prevent transfer attempts
- Only the contract owner can mint and burn tokens
- Checks for duplicate minting attempts

## Development Tools

**Foundry** consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools)
-   **Cast**: Swiss army knife for interacting with EVM smart contracts
-   **Anvil**: Local Ethereum node for testing
-   **Chisel**: Fast, utilitarian Solidity REPL

## Getting Started

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Rust
- Git

### Installation

1. Clone the repository:
```shell
git clone <repository_url>
cd erc-721
```

2. Install dependencies:
```shell
forge install
```

## Usage

### Build Project

```shell
forge build
```

### Run Tests

```shell
forge test
```

### Format Code

```shell
forge fmt
```

### Generate Gas Report

```shell
forge snapshot
```

### Local Development

Start a local node:
```shell
anvil
```

### Deployment

Deploy to network:
```shell
forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

## Integration Guide

### For Service Providers

To integrate this identity system into your service:

1. Check if a user has a valid identity token:
```solidity
bool hasIdentity = identitySBT.hasToken(userAddress);
```

2. Use the token URI to access identity metadata:
```solidity
string memory uri = identitySBT.tokenURI(tokenId);
```

## Documentation

- [Foundry Documentation](https://book.getfoundry.sh/)
- [ERC-721 Standard](https://eips.ethereum.org/EIPS/eip-721)
- [OpenZeppelin Docs](https://docs.openzeppelin.com/)

## Security Considerations

- Built on audited OpenZeppelin contracts
- Non-transferable design prevents token theft
- Owner-only minting prevents unauthorized identities
- Recommend security audit before mainnet deployment

## Contributing

We welcome contributions to the project:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.