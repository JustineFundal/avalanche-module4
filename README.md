# avalanche-module4


##DEGENTOKEN Smart Contract
#Overview
DEGENTOKEN is an ERC20 token implemented in Solidity. It includes functionalities for minting, transferring, redeeming, and burning tokens. The contract leverages OpenZeppelin's libraries for standard ERC20 implementation and ownership management.


#Features
Minting: Only the contract owner can mint new tokens.

Transferring: Standard ERC20 token transfer functionality.

Redeeming: Tokens can be redeemed for in-game items, which burns the redeemed tokens.

Burning: Users can burn their own tokens.


#Smart Contract Details

SPDX License

This project is licensed under the MIT License.


#Prerequisites

Solidity ^0.8.25

OpenZeppelin Contracts


Import Statements

The contract imports the following from OpenZeppelin:

Contract: DEGENTOKEN


#Constructor

Initializes the token with the name "DEGEN TOKEN" and symbol "DGN". The initial owner is set upon deployment.


#Events
The contract includes the following events:

TokensMinted(address indexed recipient, uint256 amount)

TokensTransferred(address indexed from, address indexed to, uint256 amount)

TokensRedeemed(address indexed redeemer, uint256 amount)

TokensBurned(address indexed burner, uint256 amount)




##Functions
#Mint Tokens

Mints new tokens to the specified address. Only the contract owner can call this function.


#Transfer Tokens

Transfers tokens from the caller's address to the specified address. Emits a TokensTransferred event.


#Redeem Tokens

Allows users to redeem tokens for in-game items, burning the tokens in the process. Emits a TokensRedeemed event.


#Check Balance

Returns the token balance of the specified address.


#Burn Tokens

Allows users to burn their own tokens. Emits a TokensBurned event.


#Deployment
To deploy the contract, use the following constructor parameter:


initialOwner (address): The initial owner of the contract.


#License
This project is licensed under the MIT License.

