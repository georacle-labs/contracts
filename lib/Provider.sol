//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Provider {
    struct Node {
        bytes32 pubkey; //  public key
        bytes32 netAddr; // network address
    }
}
