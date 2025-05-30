// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {IdentitySBT} from "../src/IdentitySBT.sol";
import {console} from "forge-std/console.sol";

contract BurnIdentitySBT is Script {
    address constant IDENTITY_SBT_ADDRESS = 0xb117d1c006fC208FEAFFE5E08529BE5de8235B73;

    function run() public {
        vm.startBroadcast();

        IdentitySBT sbt = IdentitySBT(IDENTITY_SBT_ADDRESS);

        address from = 0x217d48E05a1C4DEc30f0086DB9dC2973d6B9A00b;
        
        sbt.burn(from);
        console.log("Burned IdentitySBT from:", from);

        // Stop broadcasting
        vm.stopBroadcast();
    }
} 