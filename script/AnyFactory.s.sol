// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import { AnyFactory } from "../src/AnyFactory.sol";

contract AnyFactoryDeploy is Script {
    function run() external {
        address deployer = vm.rememberKey(vm.envUint("PRIVATE_KEY"));

        vm.startBroadcast(deployer);

        new AnyFactory();

        vm.stopBroadcast();
    }
}
