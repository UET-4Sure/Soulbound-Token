// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


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
        return hasMinted[user];
    }

    function _update(address to, uint256 tokenId, address auth)
        internal
        override
        returns (address)
    {
        address from = _ownerOf(tokenId);
        require(from == address(0) || to == address(0), "IdentitySBT: transfer not allowed");
        return super._update(to, tokenId, auth);
    }

    function approve(address, uint256) public pure override(ERC721, IERC721) {
        revert("IdentitySBT: approve not allowed");
    }

    function setApprovalForAll(address, bool) public pure override(ERC721, IERC721) {
        revert("IdentitySBT: approval not allowed");
    }
}
