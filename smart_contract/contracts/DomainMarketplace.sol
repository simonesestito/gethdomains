// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Domain.sol";

/// @title DomainMarketplace
/// @notice Implementation of the DomainMarketplace contract, following ERC721 interface for interoperability.
///         This is the contract that regulates the NFT Domain name marketplace and registration.
/// @dev Extension of ERC721 that allows the owner to put a domain for sale and to sell it.
///      The contract is Ownable, so some operations will be restricted to the owner.
///      The contract is also ERC721Royalty, so it can easily manage royalties on domain sales.
contract DomainMarketplace is ERC721Royalty, Ownable {
    /// @notice Pointer to the Geth token contract, used to perform actions on users' balances.
    /// @dev This is kept as a state variable because its address is only known after deployment.
    ///      But it is immutable: it can be set only once in the constructor.
    IERC20 private gethTokensContract;

    /// @notice The base price of a domain, in Geth.
    /// @dev This is kept as a state variable because it can be changed by the owner.
    uint32 public newDomainPrice = 10;

    /// @notice Numerator of the royalty fees fraction.
    /// @dev This is hard-coded, since (in addition to _feeDenominator()) the royalty is 5%.
    uint96 private constant feeNumerator = 1;

    /// @notice The mapping of domains' information, given the bytes of an encoded name.
    /// @dev It can be noticed that the bytes (key) are not included in Domain struct, since they would be redundant.
    ///      The mapping is public: this allows the creation of a getter function, which is needed by the frontend.
    mapping(bytes => Domain) public domains;

    /// @notice The list of all the domains' names, used to iterate over the mapping.
    /// @dev This is needed because Solidity does not allow to iterate over a mapping.
    ///      It is also important to keep this list consistent with the mapping.
    bytes[] private domainsKeys;

    /// @notice Modifier to check that the caller is the owner of the domain.
    /// @dev This is used to restrict some operations to the owner of the domain.
    ///      Solidity modifiers are used following the Decorator pattern.
    modifier onlyDomainOwner(bytes calldata domain) {
        uint256 id = uint256(keccak256(abi.encodePacked(domain)));
        require(msg.sender == ownerOf(id), "This operation is restricted to the owner of the domain");
        _;
    }

    /// @notice Event emitted when a domain is put for sale.
    /// @dev This is used to notify the frontend that a domain is for sale, and so it's able to update the list.
    /// @param domain The domain name, encoded as bytes.
    /// @param seller The address of the seller (previous owner).
    /// @param price The price of the domain, in Geth.
    event DomainForSale(bytes domain, address indexed seller, uint256 price);

    /// @notice Event emitted when a domain is sold.
    /// @dev This is used to notify the frontend that a domain has been sold, and so it's able to update the list.
    ///      The price is not included, since it is considered useless.
    /// @param seller The address of the seller (previous owner).
    /// @param buyer The address of the buyer (new owner).
    /// @param domain The domain name, encoded as bytes.
    event DomainSold(address seller, address indexed buyer, bytes domain);

    /// @notice Event emitted when a domain is sold, and the original owner receives royalties.
    /// @dev The original owner is the creator of the domain, and receives royalties only if the domain has been resold.
    ///      It may or may not be the same as the seller.
    /// @param originalOwner The address of the original owner (creator).
    /// @param buyer The address of the buyer (new owner).
    /// @param domain The domain name, encoded as bytes.
    /// @param royaltiesAmount The amount of royalties received by the original owner, in Geth.
    event RoyaltiesPaid(address indexed originalOwner, address indexed buyer, bytes domain, uint256 royaltiesAmount);

    /// @notice Event emitted when a domain is edited, and now it points to a different Tor or IPFS address.
    /// @dev This is used to notify the frontend that a domain has been edited,
    ///      and so it's able to update the search results and the list.
    /// @param domain The domain name, encoded as bytes.
    /// @param owner The address of the owner, so that a listener can filter events based on some of these criteria.
    event DomainPointerEdited(bytes domain, address indexed owner);

    /// @notice Constructor of the contract, which sets the Geth token contract address.
    /// @dev The Geth token contract address is immutable, and can be set only once.
    ///      It is also hard-coded in the constructor, because this contract is deployed after the Geth token contract.
    ///      Also, the deployer must remember to approve this contract to spend Geth tokens (see: Geth.setOperator()).
    constructor() ERC721("GethDomain", "GETHD") Ownable(msg.sender) {
        // It is important to keep a reference to the Geth token contract
        gethTokensContract = IERC20(0xa514C64fd0e5Fe44B2C4448AfB8C6f3268232169);
    }

    /// @notice Set the denominator of the royalty fraction.
    ///         This is used by the ERC721Royalty contract to calculate the royalties.
    /// @dev The value is hard-coded, since it is not supposed to change.
    ///      The numerator is always 1, since the royalty is 5%.
    function _feeDenominator() internal pure override returns (uint96) {
        return 20;
    }

    /// @notice Register a new domain, given its name and the address it points to.
    ///         The domain is minted as an NFT, and the creator will be able to receive royalties on its future sales.
    /// @dev The domain name is encoded as bytes, and then hashed to get the ID of the NFT.
    ///      The domain is minted to the creator, and the price is set to 0, since it is not for sale.
    ///      The domain is also set to point to the given address.
    ///      The creator must have enough Geth tokens to pay the registration fee.
    ///      Emits a {Transfer} event for the NFT and also for the amount of Geth spent.
    /// @param domain The domain name, encoded as bytes, according to the encoding library in the frontend.
    /// @param torOrIpfs The address the domain points to, encoded as bytes, according to the encoding library in the frontend.
    /// @param isTor A boolean flag indicating whether the domain points to a Tor address or an IPFS CID.
    function purchaseNewDomain(bytes calldata domain, bytes calldata torOrIpfs, bool isTor) external {
        // Ensure that the domain is not already registered
        require(domains[domain].resoldTimes == 0, "Domain already created");

        // Ensure that the creator has enough Geth tokens to pay the registration fee
        require(gethTokensContract.balanceOf(msg.sender) >= newDomainPrice, "Insufficient Geth, buy them with getGeth func");

        // Subtract the registration fee from the creator's balance
        gethTokensContract.transferFrom(msg.sender, address(this), newDomainPrice);

        // Mint the domain to the creator
        // The ID is computed as the hash of the domain name
        uint256 nextId = uint256(keccak256(abi.encodePacked(domain)));
        _mint(msg.sender, nextId);
        _setTokenRoyalty(nextId, msg.sender, feeNumerator);

        // Set the domain information, keeping also the domainsKeys list consistent
        domains[domain] = Domain(0, 0, torOrIpfs, isTor);
        domainsKeys.push(domain);

        // A new domain is created, and it is considered sold for the first time
        domains[domain].resoldTimes++;
    }

    /// @notice Purchase an existing domain, given its name and the price.
    ///         The domain is transferred to the buyer, and the seller receives the price.
    ///         The creator of the domain receives royalties, if the domain has been resold.
    /// @dev The domain name must already be for sale, otherwise the transaction will revert.
    ///      The buyer must have enough Geth tokens to pay the price.
    ///      Emits a {Transfer} event for the NFT and also for the amount of Geth spent.
    ///      Emits a {RoyaltiesPaid} event for the amount of royalties paid to the creator.
    ///      Emits a {DomainSold} event for the domain name, the seller and the buyer.
    /// @param domain The domain name, encoded as bytes, according to the encoding library in the frontend.
    /// @param price The price of the domain, in Geth.
    ///              This is specified also here as a parameter, even if it's stored in the mapping,
    ///              to avoid consistency issues with the client.
    ///              For instance, the client may have fetched the domain information before the price was changed.
    function purchaseExistingDomain(bytes calldata domain, uint32 price) external {
        // Calculate the ID of the domain as the hash of its name
        uint256 id = uint256(keccak256(abi.encodePacked(domain)));
        address seller = ownerOf(id);

        // Verify that the buyer is not the owner of the domain
        require(msg.sender != seller, "You cannot buy your own domain");

        // Check that the requested price is the actual one (avoid consistency issues with the client)
        require(domains[domain].price == price, "Domain price changed");

        // Verify that the buyer has enough Geth tokens to pay the price
        require(gethTokensContract.balanceOf(msg.sender) >= domains[domain].price, "Insufficient payment");

        // Verify that the domain is for sale
        require(domains[domain].price > 0, "Domain not for sale");

        // Increment the number of times the domain has been resold
        domains[domain].resoldTimes++;

        // Calculate the royalties amount, and send them to the creator of the domain
        uint256 royaltyAmount = _handleRoyalties(domain, id);

        // Calculate the final earning for the seller,
        // subtracting the royalties amount from the desired price
        uint256 realAmount = domains[domain].price - royaltyAmount;

        // Transfer the price to the seller
        gethTokensContract.transferFrom(msg.sender, seller, realAmount);

        // Transfer the domain to the buyer
        _transfer(seller, msg.sender,id);

        // Remove the domain for sale
        domains[domain].price = 0;

        // Emit the associated event
        emit DomainSold(seller, msg.sender, domain);
    }

    /// @notice Handle the logic associated with royalties calculation and transfer.
    /// @dev This function is called by {purchaseExistingDomain}, and it is extracted to improve readability.
    ///      The function is internal, since it is not supposed to be called by the frontend.
    /// @param domain The domain name, encoded as bytes, according to the encoding library in the frontend.
    /// @param id The ID of the domain, computed as the hash of its name.
    /// @return The amount of royalties paid to the creator of the domain, in Geth.
    function _handleRoyalties(bytes calldata domain, uint256 id) internal returns (uint256) {
        // Compute the royalties amount, provided by the ERC721Royalty contract
        (address receiver, uint256 royaltyAmount) = royaltyInfo(id, domains[domain].price);

        // Send the royalties to the creator of the domain, if it has been resold
        gethTokensContract.transferFrom(msg.sender, receiver, royaltyAmount);

        // Emit the associated event
        emit RoyaltiesPaid(receiver, msg.sender, domain, royaltyAmount);

        // Return the amount of royalties paid
        return royaltyAmount;
    }

    /// @notice Put a domain for sale, given its name and the price.
    /// @dev The domain name must be owned by the caller, otherwise the transaction will revert.
    ///      The price must be greater than 0, otherwise the transaction will revert.
    ///      Emits a {DomainForSale} event for the domain name, the seller and the price.
    /// @param domain The domain name, encoded as bytes, according to the encoding library in the frontend.
    /// @param price The price of the domain, in Geth.
    function sellDomain(bytes calldata domain, uint32 price) external onlyDomainOwner(domain) {
        require(domains[domain].price == 0, "Domain already for sale");
        require(price > 0, "A domain cannot be sold for free");

        // Put the domain for sale, informing the frontend via event
        domains[domain].price = price;
        emit DomainForSale(domain, msg.sender, price);
    }

    /// @notice Remove a domain from sale, given its name.
    /// @dev The domain name must be owned by the caller, otherwise the transaction will revert.
    ///      The domain must be for sale, otherwise the transaction will revert.
    ///      Emits a {DomainForSale} event for the domain name, the seller and the price (0 = not for sale).
    /// @param domain The domain name, encoded as bytes, according to the encoding library in the frontend.
    function retrieveDomain(bytes calldata domain) external onlyDomainOwner(domain){
        require(domains[domain].price > 0, "Domain not for sale");

        // Remove the domain from sale, informing the frontend via event
        domains[domain].price = 0;
        emit DomainForSale(domain, msg.sender, 0);
    }

    /// @notice Edit a domain, given its name and the Tor address it will point to.
    /// @dev The domain name must be owned by the caller, otherwise the transaction will revert.
    ///      Emits a {DomainPointerEdited} event.
    /// @param domain The domain name, encoded as bytes, according to the encoding library in the frontend.
    /// @param torAddress The address the domain points to, encoded as bytes, according to the encoding library in the frontend.
    function setTor(bytes calldata domain, bytes calldata torAddress) external onlyDomainOwner(domain) {
        require(torAddress.length > 0, "You must specify a Tor address");

        // Set the domain information, informing the frontend via event
        domains[domain].pointedAddress = torAddress;
        domains[domain].isTor = true;
        emit DomainPointerEdited(domain, msg.sender);
    }

    /// @notice Edit a domain, given its name and the IPFS address it will point to.
    /// @dev The domain name must be owned by the caller, otherwise the transaction will revert.
    ///      Emits a {DomainPointerEdited} event.
    /// @param domain The domain name, encoded as bytes, according to the encoding library in the frontend.
    /// @param ipfsAddress The address the domain points to, encoded as bytes, according to the encoding library in the frontend.
    function setIpfs(bytes calldata domain, bytes calldata ipfsAddress) external onlyDomainOwner(domain) {
        require(ipfsAddress.length > 0, "You must specify an IPFS address");

        // Set the domain information, informing the frontend via event
        domains[domain].pointedAddress = ipfsAddress;
        domains[domain].isTor = false;
        emit DomainPointerEdited(domain, msg.sender);
    }

    /// @notice Set the price of a new domain, in Geth.
    /// @dev This function can be called only by the contract owner, because of its security implications.
    /// @param price The new price of a new domain, in Geth.
    function setNewDomainPrice(uint32 price) external onlyOwner {
        newDomainPrice = price;
    }

    /// @notice Utility function to calculate the ID of a domain, given its name.
    /// @dev This function is used by the frontend to calculate the ID of a domain, given its name.
    ///      This is pure function, since it does not read or write any state variable.
    /// @param domain The domain name, encoded as bytes, according to the encoding library in the frontend.
    function getId(bytes calldata domain) external pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(domain)));
    }

    /// @notice Utility function to get the list of domains owned by a user.
    /// @dev This function is used by the frontend to get the list of domains owned by a user.
    ///      This is a view function, since it does not write any state variable.
    ///      It is faster to call this function and run this code directly in one call(),
    ///      rather than {ownerOf} for each existing domain via web3.js or other APIs, in independent call() invocations.
    ///      Also, keeping an ad-hoc data structure would be too expensive.
    ///      The invocation cost is zero, since we can simply use call() instead of send().
    /// @param user The address of the user.
    /// @return The list of domains owned by the user, as bytes and as structs,
    ///         because the structs doesn't have the bytes data of the encoded domain name.
    function getUserDomains(address user) external view returns (bytes[] memory, Domain[] memory) {
        // First, since in Solidity I must specify the size of the array,
        // I need to know how many domains are owned by the user.
        uint256 userDomains = balanceOf(user);
        bytes[] memory ownedDomainBytes = new bytes[](userDomains);
        Domain[] memory ownedDomainStructs = new Domain[](userDomains);

        // Iterate over the list of domains, and populate the arrays
        // We can stop earlier if we already found all the domains owned by the user
        uint256 j = 0;
        for (uint256 i = 0; i < domainsKeys.length && j < userDomains; i++) {
            // Populate the arrays with the domains owned by the user
            bytes memory domain = domainsKeys[i];
            if (ownerOf(uint256(keccak256(abi.encodePacked(domain)))) == user) {
                ownedDomainBytes[j] = domain;
                ownedDomainStructs[j] = domains[domain];
                j += 1;
            }
        }

        return (ownedDomainBytes, ownedDomainStructs);
    }

    /// @notice Utility function to get the information about a domain, given its ID.
    /// @dev This function is used by the frontend to get the information about a domain, given its ID.
    ///      This is a view function, since it does not write any state variable.
    ///      It is faster to call this function and run this code directly in one call(),
    ///      rather than calculating the ID via web3.js or other APIs.
    ///      Having an inverted mapping (ID => domain) would be too expensive.
    ///      The invocation cost is zero, since we can simply use call() instead of send().
    /// @param id The ID of the domain, computed as the hash of its name.
    /// @return The domain name, encoded as bytes, and the struct containing the domain information.
    function getDomainById(uint256 id) external view returns (bytes memory, Domain memory) {
        // Iterate over the list of domains, and return the first one with the given ID
        for (uint256 i = 0; i < domainsKeys.length; i++) {
            bytes memory domain = domainsKeys[i];
            if (uint256(keccak256(abi.encodePacked(domain))) == id) {
                return (domain, domains[domain]);
            }
        }

        // If no domain is found, return an empty domain
        // This can be easily checked on the frontend, since the domain name is empty
        return ("", Domain(0, 0, "", false));
    }

    /// @notice Utility function to get the list of domains for sale.
    /// @dev This function is used by the frontend to get the list of domains for sale.
    ///      This is a view function, since it does not write any state variable.
    ///      It is faster to call this function and run this code directly in one call(),
    ///      rather than iterating over the list of domains via web3.js or other APIs.
    ///      The invocation cost is zero, since we can simply use call() instead of send().
    /// @return The list of domains for sale, as bytes and as structs.
    function getDomainsForSale() external view returns (bytes[] memory, Domain[] memory) {
        // First, since in Solidity I must specify the size of the array,
        // I need to know how many domains are for sale.
        uint256 domainsForSale = 0;
        for (uint256 i = 0; i < domainsKeys.length; i++) {
            bytes memory domain = domainsKeys[i];
            if (domains[domain].price > 0) {
                domainsForSale += 1;
            }
        }

        // Then, I can create the array of the right size
        // On the frontend, I need both the bytes (to display the name)
        // and the struct (containing other information)
        bytes[] memory domainsForSaleBytes = new bytes[](domainsForSale);
        Domain[] memory domainsForSaleStructs = new Domain[](domainsForSale);
        uint256 j = 0;
        for (uint256 i = 0; i < domainsKeys.length && j < domainsForSale; i++) {
            bytes memory domain = domainsKeys[i];
            if (domains[domain].price > 0) {
                domainsForSaleBytes[j] = domain;
                domainsForSaleStructs[j] = domains[domain];
                j += 1;
            }
        }

        return (domainsForSaleBytes, domainsForSaleStructs);
    }
}