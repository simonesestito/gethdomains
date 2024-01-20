// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.20;

/// @notice Struct containing the information about a domain.
/// @dev The struct is used to store the information about a domain, in a memory efficient way.
///      For instance, the ID used by ERC721 is not stored, since it can be computed from the domain name (= keccak256(domain)).
struct Domain {
    /// @notice The price of the domain, in wei. If 0, the domain is not for sale.
    /// @dev The price is stored as a uint32, to save space.
    uint32 price;
    
    /// @notice The number of times the domain has been resold.
    uint32 resoldTimes;

    /// @notice The pointed address, saved as an encoded byte array, which represents either a Tor address or an IPFS CID.
    /// @dev The address is stored following the encoding implemented by the decoder library.
    ///      For Tor addresses, this is the public key, while for IPFS CID this is the multihash.
    bytes pointedAddress;

    /// @notice A boolean flag indicating whether the domain points to a Tor address or an IPFS CID.
    /// @dev This flag is used to avoid decoding the address to check its type.
    bool isTor;
}