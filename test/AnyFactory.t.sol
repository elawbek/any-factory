// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import { AnyFactory } from "../src/AnyFactory.sol";

contract AnyFactoryTest is Test {
    AnyFactory anyFactory;

    address usdt = 0xdAC17F958D2ee523a2206206994597C13D831ec7;

    function setUp() external {
        vm.createSelectFork(vm.rpcUrl("ethereum"));
        anyFactory = new AnyFactory();
    }

    function test() external {
        anyFactory.deploy(usdt, bytes(""));
    }
}
