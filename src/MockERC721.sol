// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract IdentitySBT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    mapping(address => bool) public hasMinted;

    mapping(address => uint256) public addressToTokenId;

    constructor() ERC721("Verified Identity", "VID") Ownable(msg.sender) {}

    function mint(address to, string memory uri) external onlyOwner {
        require(!hasMinted[to], "IdentitySBT: already minted");

        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        hasMinted[to] = true;
        addressToTokenId[to] = tokenId;
    }

    function burn(address from) external onlyOwner {
        require(hasMinted[from], "IdentitySBT: no token to burn");
        uint256 tokenId = addressToTokenId[from];

        _burn(tokenId);

        hasMinted[from] = false;
        delete addressToTokenId[from];
    }

    function hasToken(address user) public view returns (bool) {
        return addressToTokenId[user] != 0;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);

        if (from != address(0) && to != address(0)) {
            revert("IdentitySBT: transfer not allowed");
        }
    }

    function approve(address, uint256) public pure override {
        revert("IdentitySBT: approve not allowed");
    }

    function setApprovalForAll(address, bool) public pure override {
        revert("IdentitySBT: approval not allowed");
    }
}
