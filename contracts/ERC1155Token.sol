// SPDX-License-Identifier: MIT
// Version of solidity compiler used
pragma solidity ^0.8.9;

// the necessary Openzeppelin contacts for our smart contact was imported
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// CharacterXYZ inherits ERC1155, ERC1155URIStorage, ERC1155Supply, Ownable contacts
contract CharacterXYZ is ERC1155, ERC1155URIStorage, ERC1155Supply, Ownable {
    constructor() ERC1155("https://arweave.net/") {}

    // Variable to store No. of different NFTs avaialble to mint
    uint256 private NFTs = 0;

    // used to store the maximum supply for each available token
    mapping(uint256 => uint256) private maxSupply;

    //function to set the value of variable NFTs
    function setNumOfNFTs(uint256 num) public onlyOwner {
        NFTs = num;
    }

    // function to return the value of variable NFTs
    function numOfNFTs() public view returns (uint256) {
        return NFTs;
    }

    // function to set the maximum supply for tokens
    function setMaxSupply(uint256 id, uint256 amt) public onlyOwner {
        require(
            id <= NFTs,
            "Sorry, you are trying to set supply for non-exist NFT"
        );
        maxSupply[id] = amt;
    }

    // function to return the maximum supply of a token
    function getMaxSupply(uint256 id) public view returns (uint256) {
        return maxSupply[id];
    }

    // function to set the base URI of all the NFTs
    function setBaseURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
        _setBaseURI(newuri);
    }

    // function used to set the token specific URI
    function setTokenURI(uint256 id, string memory tokenuri) public onlyOwner {
        require(
            id <= NFTs,
            "Sorry, you are trying to set URI for non-exist NFT"
        );
        _setURI(id, tokenuri);
    }

    // function to return the URI for given Id
    function uri(
        uint256 tokenId
    )
        public
        view
        virtual
        override(ERC1155, ERC1155URIStorage)
        returns (string memory)
    {
        require(
            tokenId <= NFTs,
            "Sorry, you are trying to retrive URI for non-exist NFT"
        );
        return super.uri(tokenId);
    }

    // function to mint tokens accorging to given data
    function mint(uint256 id, uint256 amount, bytes memory data) public {
        require(id <= NFTs, "Sorry, you are trying to mint the non-exist NFT");
        require(
            maxSupply[id] - totalSupply(id) >= amount,
            "Sorry, Insufficent tokens to mint"
        );
        _mint(msg.sender, id, amount, data);
    }

    // Should override the below function, Bcz two functions are exist with same name
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
