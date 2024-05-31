// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DEGENTOKEN is ERC20, Ownable {
    event TokensMinted(address indexed recipient, uint256 amount);
    event TokensTransferred(address indexed from, address indexed to, uint256 amount);
    event TokensRedeemed(address indexed redeemer, uint256 amount);
    event TokensBurned(address indexed burner, uint256 amount);

    constructor(address initialOwner) ERC20("DEGEN TOKEN", "DGN") Ownable(initialOwner) {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
        emit TokensTransferred(_msgSender(), to, amount);
        return true;
    }

    function redeem(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        // Additional logic for redeeming tokens for items in the in-game store
        _burn(msg.sender, amount);
        emit TokensRedeemed(msg.sender, amount);
    }

    function checkBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    function burn(uint256 amount) external {
        require(amount > 0 && balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }
}


