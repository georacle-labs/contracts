//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/UnorderedSet.sol";

contract Providers {
    using UnorderedSet for UnorderedSet.Set;
    UnorderedSet.Set oracles;

    event ProviderJoin(
        address indexed p,
        bytes32 indexed pubkey,
        bytes32 indexed netAddr
    );

    event ProviderExit(
        address indexed p,
        bytes32 indexed pubkey,
        bytes32 indexed netAddr
    );

    modifier ValidPubkey(bytes32 pubkey) {
        require(uint256(pubkey) != 0, "Invalid public key");
        _;
    }

    /* @notice Join the provider network
     * @param pubkey the node's public key
     * @param netAddr the associated network address
     */
    function join(bytes32 pubkey, bytes32 netAddr) public ValidPubkey(pubkey) {
        oracles.add(msg.sender, pubkey, netAddr);
        emit ProviderJoin(msg.sender, pubkey, netAddr);
    }

    /* @notice Exit the provider network
     */
    function exit() public {
        Provider.Node memory p = oracles.remove(msg.sender);
        emit ProviderExit(msg.sender, p.pubkey, p.netAddr);
    }

    /* @notice Lookup a provider by address
     * @return a provider's details (if exists)
     */
    function lookup(address a) public view returns (Provider.Node memory) {
        return oracles.getProvider(a);
    }

    /* @notice Obtain the set of providers currently in the network
     * @return a list of provider addresses
     */
    function getProviders() public view returns (address[] memory) {
        return oracles.getKeys();
    }
}
