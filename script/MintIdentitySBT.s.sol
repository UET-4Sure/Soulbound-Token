// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {IdentitySBT} from "../src/IdentitySBT.sol";
import {console} from "forge-std/console.sol";

contract MintIdentitySBT is Script {
    address constant IDENTITY_SBT_ADDRESS = 0xb117d1c006fC208FEAFFE5E08529BE5de8235B73;

    function run() public {
        vm.startBroadcast();

        IdentitySBT sbt = IdentitySBT(IDENTITY_SBT_ADDRESS);

        address to = 0x5cD8944d70CeDd0A3F95aa089d2E8bA21b5edbF7;
        
        string memory uri = "ipfs://";

        sbt.mint(to, uri);
        console.log("Minted IdentitySBT to:", to);

        // Stop broadcasting
        vm.stopBroadcast();
    }
} 