// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

import {Pelusa} from "src/Pelusa.sol";
import {PelusaAttack} from "src/PelusaAttack.sol";
import {PelusaAttackDeployer} from "src/PelusaAttackDeployer.sol";

contract Weth10Test is Test {
    Pelusa public pelusa;
    PelusaAttack public pelusaAttack;
    PelusaAttackDeployer public pelusaAttackDeployer;

    address diego;

    function setUp() public {
        diego = makeAddr("diego");
    }

    function testHack() public {
       vm.startPrank(diego,diego);

       pelusa = new Pelusa();
       pelusaAttackDeployer = new PelusaAttackDeployer();
       pelusaAttack = PelusaAttack(pelusaAttackDeployer.deploy(getOwnerAddress(diego),address(pelusa)));
       pelusa.shoot();

       assertEq(pelusa.isGoal(), true, "isGoal");
       assertEq(pelusa.goals(), 2, "Diego score");      
       vm.stopPrank();
    }

    function getOwnerAddress(address caller) internal pure returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(caller, bytes32(0))))));
    }

}