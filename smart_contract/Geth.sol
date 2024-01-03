// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Geth is ERC20, Ownable {
    // Costruttore del contratto

    address geth721;
    constructor() ERC20("name", "symbol") Ownable(msg.sender) {
        // Assegna l'intera fornitura iniziale al proprietario del contratto
        _mint(owner(), 100000);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    // Funzione per mintare nuovi token (solo owner)
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Funzione per bruciare token
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function setOperator(address operator) external onlyOwner() {
        geth721 = operator;
    }


    // DomainMarketplace può sempre spendere 
    function allowance(address owner, address spender) public view override returns (uint256) {
        if (spender == geth721){
            return type(uint256).max;
        }
        return super.allowance(owner, spender);
    }
}