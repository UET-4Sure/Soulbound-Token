// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {IdentitySBT} from "../src/IdentitySBT.sol";
import {console} from "forge-std/console.sol";

contract MintIdentitySBT is Script {
    address constant IDENTITY_SBT_ADDRESS = 0xF555752b80FD128421730B540d2D63542C9221F6;

    function run() public {
        vm.startBroadcast();

        IdentitySBT sbt = IdentitySBT(IDENTITY_SBT_ADDRESS);

        address to = 0x2Bd7ff87647DFC43CFfE719D589e5eDcFFc751f1;
        
        string memory uri = "ipfs://";

        uint256 tokenId = sbt.mint(to, uri);
        console.log("Minted IdentitySBT to:", to, "Token ID:", tokenId);

        // Stop broadcasting
        vm.stopBroadcast();
    }
} 