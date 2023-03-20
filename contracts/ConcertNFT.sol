// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ConcertNFT is ERC721, Ownable {
    string public constant NAME = "ConcertNFT";
    string public constant SYMBOL = "CTNFT";

    uint256 public tokenCounter;
    uint256 public totalConcerts;

    constructor() ERC721(NAME, SYMBOL) {
        totalConcerts = 0;
    }

    struct Concert {
        string artist;
        string location;
        uint256 date;
        uint256 price;
        bool forSale;
    }

    mapping(uint256 => Concert) public concerts;

    event ConcertCreated(
        uint256 indexed id,
        string artist,
        string location,
        uint256 date,
        uint256 price,
        bool forSale
    );

    event ConcertUpdated(
        uint256 indexed id,
        string artist,
        string location,
        uint256 date,
        uint256 price,
        bool forSale
    );

    function createConcert(
        string memory _artist,
        string memory _location,
        uint256 _date,
        uint256 _price
    ) public onlyOwner returns (uint256) {
        uint256 tokenId = totalConcerts;
        Concert memory newConcert = Concert({
            artist: _artist,
            location: _location,
            date: _date,
            price: _price,
            forSale: false
        });
        concerts[tokenId] = newConcert;
        emit ConcertCreated(
            tokenId,
            newConcert.artist,
            newConcert.location,
            newConcert.date,
            newConcert.price,
            newConcert.forSale
        );
        _safeMint(msg.sender, tokenId);
        totalConcerts++;
        return tokenId;
    }

    function updateConcert(
        uint256 _tokenId,
        string memory _artist,
        string memory _location,
        uint256 _date,
        uint256 _price,
        bool _forSale
    ) public onlyOwner {
        require(_exists(_tokenId), "ConcertNFT: Token does not exist.");
        Concert storage concert = concerts[_tokenId];
        concert.artist = _artist;
        concert.location = _location;
        concert.date = _date;
        concert.price = _price;
        concert.forSale = _forSale;
        emit ConcertUpdated(
            _tokenId,
            concert.artist,
            concert.location,
            concert.date,
            concert.price,
            concert.forSale
        );
    }

    function buyConcert(uint256 _tokenId) public payable {
        require(_exists(_tokenId), "ConcertNFT: Token does not exist.");
        Concert storage concert = concerts[_tokenId];
        require(concert.forSale == true, "ConcertNFT: Token not for sale.");
        require(msg.value >= concert.price, "ConcertNFT: Not enough Ether sent.");
        address payable owner = payable(ownerOf(_tokenId));
        owner.transfer(msg.value);
        _safeTransfer(owner, msg.sender, _tokenId, "");
        concert.forSale = false;
    }

    function setConcertForSale(uint256 _tokenId, bool _forSale) public onlyOwner {
        require(_exists(_tokenId), "ConcertNFT: Token does not exist.");
        Concert storage concert = concerts[_tokenId];
        concert.forSale = _forSale;
    }
}