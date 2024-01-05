// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./node_modules/@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev Extension of {ERC20} that allows {DomainMarketplace} to get full allowance
 * on transfer coin from the balance of domain buyers. Token holders still need to 
 * approve spenders outside of DomainMarketplace. {ERC20-decimals} is overwritten
 * to have 1:1 ratio between wei and {Geth}.
 */
contract Geth is ERC20, Ownable {

    uint64 constant private GETH_TO_WEI = 1000000000000000;
    address private operator;

    constructor() ERC20("Geth", "G") Ownable(msg.sender) {}

    /**
     * @dev See {ERC20-decimals}.
     */
    function decimals() public pure override returns (uint8) {
        return 0;
    }

    /**
     * @dev function to buy tokens with Ether and transfer them to the buyer.
     */
    function purchaseTokens() external payable {
        uint256 tokenAmount = calculateTokenAmount(msg.value);
        // se volessimo mettere un maxSupply
        // require(balanceOf(address(this)) >= tokenAmount, "Insufficient token balance in the contract");

        // Trasferisci i token all'acquirente
        transfer(msg.sender, tokenAmount);
    }

    /**
     * @dev function to calculate the amount of tokens to be transferred to the buyer.
     * Returns the amount of tokens that can be purchased with the sent amount of Ether.
     */
    function calculateTokenAmount(uint256 weiAmount) private pure returns (uint256) {
        return weiAmount / GETH_TO_WEI;
    }

    /**
     * @dev function to set the {operator} smart contract address.
     * Notice this function can be called only by the contract owner.
     * Emits a {SetSM} event.
     * Additionally, owner can set others smart contracts to spend geth,
     * but in our project only {DomainMarketplace} is allowed to do so.
     */
    function setOperator(address newOperator) external onlyOwner() {
        operator = newOperator;
    }

    /**
    * @dev See {IERC20-allowance}.
     *
     * Note that {operator} can always spend geth.
     */
    function allowance(address owner, address spender) public view override returns (uint256) {
        if (spender == operator) {
            return type(uint256).max;
        }
        return super.allowance(owner, spender);
    }
}