// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {IdentitySBT} from "../src/IdentitySBT.sol";
import {console} from "forge-std/console.sol";

contract DeployIdentitySBT is Script {
    function run() public returns (IdentitySBT) {
        // Start broadcasting transactions
        vm.startBroadcast();

        // Deploy the contract
        IdentitySBT sbt = new IdentitySBT();
        console.log("IdentitySBT deployed to:", address(sbt));

        // Stop broadcasting
        vm.stopBroadcast();

        return sbt;
    }
} 