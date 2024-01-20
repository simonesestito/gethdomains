// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Geth
/// @notice Implementation of the Geth token, following ERC20 interface for interoperability.
/// @dev Extension of ERC20 that allows DomainMarketplace to get full allowance
///      on transfer coin from the balance of domain buyers. Token holders still need to
///      approve spenders outside of DomainMarketplace. `ERC20-decimals` is overwritten
///      to have 1:1 ratio between wei and Geth.
contract Geth is ERC20, Ownable {
    /// @dev Constant to convert wei to Geth, following the rate of 1 Geth = 0.001 ETH = 1 Finney.
    uint64 private constant GETH_TO_WEI = 1000000000000000;

    /// @notice Address of the operator smart contract (DomainMarketplace).
    /// @dev This operator will be allowed to spend geth from the balance of domain buyers.
    address private operator;

    /// @notice Constructs the Geth ERC20 token, having symbol G.
    /// @dev The contract is Ownable, so some operations will be restricted to the owner.
    ///      Also, the contract is initialized with 0 total supply, to allow withdrawing
    ///      of Geth without the risk of not having ETH to pay to the withdrawer.
    constructor() ERC20("Geth", "G") Ownable(msg.sender) {}

    /// @notice Returns the number of decimals used to get its user representation.
    /// @dev Overwritten to have no decimals for simplicity.
    /// @inheritdoc ERC20
    /// @return The number of decimals.
    function decimals() public pure override returns (uint8) {
        return 0;
    }

    /// @notice Purchase Geth tokens with ETH, according to the established rate in GETH_TO_WEI.
    /// @dev The contract will mint new tokens and transfer them to the buyer.
    ///      The contract will receive in its balance the ETH amount paid.
    function purchaseTokens() external payable {
        require(msg.value > 0, "No enough ETH paid to purchase tokens");
        uint256 tokenAmount = calculateTokenAmount(msg.value);
        _mint(msg.sender, tokenAmount);
    }

    /// @notice Withdraw ETH with Geth tokens, according to the established rate in GETH_TO_WEI.
    /// @dev The contract will burn the tokens from the balance of the withdrawer.
    ///      The contract will transfer to the withdrawer the ETH amount.
    /// @param tokenAmount The amount of tokens to be burned and converted to ETH.
    function purchaseWei(uint256 tokenAmount) external {
        require(
            balanceOf(msg.sender) >= tokenAmount,
            "You don't have this amount of tokens to withdraw"
        );
        uint256 weiAmount = calculateWeiAmount(tokenAmount);

        // Burn tokens and then proceed with the transfer
        _burn(msg.sender, tokenAmount);
        payable(msg.sender).transfer(weiAmount);
    }

    /// @dev Calculate the amount of tokens that corresponds to the sent amount of ETH (expressed in Wei).
    /// @param weiAmount The amount of ETH (expressed in Wei) to be converted to tokens.
    /// @return The amount of tokens that can be purchased with the sent amount of ETH.
    function calculateTokenAmount(uint256 weiAmount) private pure returns (uint256) {
        return weiAmount / GETH_TO_WEI;
    }

    /// @dev Calculate the amount of ETH (expressed in Wei) that corresponds to the sent amount of tokens.
    /// @param tokenAmount The amount of tokens to be converted to ETH (expressed in Wei).
    /// @return The amount of ETH (expressed in Wei) that corresponds to the sent amount of tokens.
    function calculateWeiAmount(uint256 tokenAmount) private pure returns (uint256) {
        return GETH_TO_WEI * tokenAmount;
    }

    /// @notice Set the {operator} smart contract address.
    ///         It will be allowed to spend geth from the balance of domain buyers, without approval.
    /// @dev This function can be called only by the contract owner, because of its security implications.
    /// @param newOperator The address of the new operator smart contract.
    function setOperator(address newOperator) external onlyOwner {
        operator = newOperator;
    }

    /// @notice Establish the amount that the {spender} can spend from the {owner} balance.
    /// @dev This function has been overwritten to comply with the specification that states that
    ///      the operator should be allowed to spend geth from the balance of domain buyers.
    /// @inheritdoc ERC20
    /// @param owner The address of the owner of the tokens.
    /// @param spender The address of the spender.
    /// @return The amount that the spender can spend from the owner balance.
    function allowance(
        address owner,
        address spender
    ) public view override returns (uint256) {
        if (spender == operator) {
            // The operator should be allowed to spend geth from the balance of domain buyers.
            // The quantity is set to the maximum value of uint256,
            // to allow the operator to spend as much as it needs to.
            return type(uint256).max;
        }

        // For all other spenders, the default allowance is returned.
        return super.allowance(owner, spender);
    }

    /// @notice Destroy the contract and transfer all the remaining ETH to the owner.
    /// @dev This function can be called only by the contract owner, because of its security implications.
    function destroy() external onlyOwner {
        selfdestruct(payable(owner()));
    }
}
