pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NftCollection is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    event CollectionCreated(address collectionAddress, string name, string symbol);
    event TokenMinted(address collectionAddress, address recipient, uint256 tokenId, string tokenUri);

    string private _baseUri;
    string private _uriSuffix;

    Counters.Counter private _counter;

    constructor(string memory name, string memory symbol, string memory baseUri) ERC721(name, symbol) {
        _baseUri = baseUri;
        _uriSuffix = ".json";

        emit CollectionCreated(address(this), name, symbol);
    }

    function mint(address recipient) external returns(uint256, string memory){
        _counter.increment();
        uint256 tokenId = _counter.current();
        string memory tokenUri = tokenURI(tokenId);
        _mint(recipient, tokenId);

        emit TokenMinted(address(this), recipient, tokenId, tokenUri);
        return(tokenId, tokenUri);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        string memory baseUri = _baseURI();
        return
            bytes(baseUri).length > 0
                ? string.concat(baseUri, tokenId.toString(), _uriSuffix)
                : "";
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseUri;
    }

     function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}