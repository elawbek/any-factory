// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import { AnyFactory } from "../src/AnyFactory.sol";

contract AnyFactoryScript is Script {
    function run(address anyFactory, address contractAddress) external {
        address deployer = vm.rememberKey(vm.envUint("PRIVATE_KEY"));

        vm.startBroadcast(deployer);

        AnyFactory(anyFactory).deploy(contractAddress, bytes(""));

        vm.stopBroadcast();
    }
}
