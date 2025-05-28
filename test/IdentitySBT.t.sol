// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {IdentitySBT} from "../src/IdentitySBT.sol";

contract IdentitySBTTest is Test {
    IdentitySBT public sbt;
    address public owner;
    address public user1;
    address public user2;
    string public constant TOKEN_URI = "ipfs://QmTest";

    function setUp() public {
        owner = makeAddr("owner");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
        
        vm.startPrank(owner);
        sbt = new IdentitySBT();
        vm.stopPrank();
    }

    function test_Constructor() public {
        assertEq(sbt.name(), "Verified Identity");
        assertEq(sbt.symbol(), "VID");
        assertEq(sbt.owner(), owner);
        assertEq(sbt.nextTokenId(), 0);
    }

    function test_Mint() public {
        vm.startPrank(owner);
        sbt.mint(user1, TOKEN_URI);
        
        assertEq(sbt.nextTokenId(), 1);
        assertTrue(sbt.hasMinted(user1));
        assertEq(sbt.addressToTokenId(user1), 0);
        assertTrue(sbt.hasToken(user1));
        assertEq(sbt.ownerOf(0), user1);
        assertEq(sbt.tokenURI(0), TOKEN_URI);
        vm.stopPrank();
    }

    function test_Mint_RevertIf_AlreadyMinted() public {
        vm.startPrank(owner);
        sbt.mint(user1, TOKEN_URI);
        
        vm.expectRevert("IdentitySBT: already minted");
        sbt.mint(user1, TOKEN_URI);
        vm.stopPrank();
    }

    function test_Mint_RevertIf_NotOwner() public {
        vm.startPrank(user1);
        vm.expectRevert();
        sbt.mint(user1, TOKEN_URI);
        vm.stopPrank();
    }

    function test_Burn() public {
        vm.startPrank(owner);
        sbt.mint(user1, TOKEN_URI);
        sbt.burn(user1);
        
        assertFalse(sbt.hasMinted(user1));
        assertEq(sbt.addressToTokenId(user1), 0);
        assertFalse(sbt.hasToken(user1));
        vm.expectRevert();
        sbt.ownerOf(0);
        vm.stopPrank();
    }

    function test_Burn_RevertIf_NoToken() public {
        vm.startPrank(owner);
        vm.expectRevert("IdentitySBT: no token to burn");
        sbt.burn(user1);
        vm.stopPrank();
    }

    function test_Burn_RevertIf_NotOwner() public {
        vm.startPrank(owner);
        sbt.mint(user1, TOKEN_URI);
        vm.stopPrank();

        vm.startPrank(user1);
        vm.expectRevert();
        sbt.burn(user1);
        vm.stopPrank();
    }

    function test_Transfer_Revert() public {
        vm.startPrank(owner);
        sbt.mint(user1, TOKEN_URI);
        vm.stopPrank();

        vm.startPrank(user1);
        vm.expectRevert("IdentitySBT: transfer not allowed");
        sbt.transferFrom(user1, user2, 0);
        vm.stopPrank();
    }

    function test_Approve_Revert() public {
        vm.startPrank(user1);
        vm.expectRevert("IdentitySBT: approve not allowed");
        sbt.approve(user2, 0);
        vm.stopPrank();
    }

    function test_SetApprovalForAll_Revert() public {
        vm.startPrank(user1);
        vm.expectRevert("IdentitySBT: approval not allowed");
        sbt.setApprovalForAll(user2, true);
        vm.stopPrank();
    }

    function test_Update_AllowsMintAndBurn() public {
        vm.startPrank(owner);
        // Test mint (from == address(0))
        sbt.mint(user1, TOKEN_URI);
        assertEq(sbt.ownerOf(0), user1);

        // Test burn (to == address(0))
        sbt.burn(user1);
        vm.expectRevert();
        sbt.ownerOf(0);
        vm.stopPrank();
    }
} 