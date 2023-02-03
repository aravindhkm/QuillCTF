// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

import {TrueXOR} from "src/TrueXOR.sol";
import {TrueXORAttack} from "src/TrueXORAttack.sol";

contract TrueXORTest is Test {
    TrueXOR public trueXOR;
    TrueXORAttack public trueXORAttack;

    address diego;

    function setUp() public {
        diego = makeAddr("diego");
    }

    function testHack() public {
       vm.startPrank(diego,diego);

       trueXOR = new TrueXOR();
       trueXORAttack = new TrueXORAttack();

       bool status = trueXOR.callMe{gas: 2000}(address(trueXORAttack));

       assertEq(status, true, "Not_Success");    
       vm.stopPrank();
    }

    function getOwnerAddress(address caller) internal pure returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(caller, bytes32(0))))));
    }

}