// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    event ServiceCreated(address indexed creator, string serviceName, uint256 serviceUnits, uint256 servicePrice);
    event ServiceRedeemed(address indexed redeemer, string serviceName, uint256 serviceUnits);

    struct Service {
        uint256 serviceUnits;
        uint256 servicePrice;
    }

    mapping(string => Service) public services;
    mapping(string ServiceName => mapping(address Redeemer => uint ServiceReceived)) public RedeemHistory;

    constructor(address initialOwner) Ownable(initialOwner) ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    function createService(string memory serviceName, uint256 serviceUnits, uint256 servicePrice) external onlyOwner {
        require(serviceUnits > 0, "Service units must be greater than zero");
        require(servicePrice > 0, "Service price must be greater than zero");

        services[serviceName] = Service({
            serviceUnits: serviceUnits,
            servicePrice: servicePrice
        });

        emit ServiceCreated(msg.sender, serviceName, serviceUnits, servicePrice);
    }

    function redeemService(address Redeemer, string memory serviceName, uint256 serviceUnits) external {
        Service storage service = services[serviceName];
        require(service.serviceUnits >= serviceUnits, "Not enough service units available");
        require(service.servicePrice * serviceUnits <= balanceOf(msg.sender), "Insufficient balance");

        _burn(msg.sender, service.servicePrice * serviceUnits);
        service.serviceUnits -= serviceUnits;
        RedeemHistory[serviceName][Redeemer] += serviceUnits;

        emit ServiceRedeemed(msg.sender, serviceName, serviceUnits);
    }

    function checkServiceBalance(string memory serviceName) external view returns (uint256 AvailableUnits, uint ServicePrice) {
        return (services[serviceName].serviceUnits, services[serviceName].servicePrice);
    }
}
