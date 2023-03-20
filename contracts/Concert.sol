// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ConcertTicket is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Concert {
        string name;
        uint256 price;
        uint256 totalTickets;
        uint256 soldTickets;
        bool isActive;
    }

    mapping(uint256 => Concert) public concerts;
    mapping(address => uint256[]) public userTickets;

    constructor() ERC721("Concert Ticket", "CT") {}

    function createConcert(
        uint256 _id,
        string memory _name,
        uint256 _price,
        uint256 _totalTickets
    ) public onlyOwner {
        require(!concerts[_id].isActive, "Concert already exists");
        concerts[_id] = Concert({
            name: _name,
            price: _price,
            totalTickets: _totalTickets,
            soldTickets: 0,
            isActive: true
        });
    }

    function buyTicket(uint256 _id) public payable {
        require(concerts[_id].isActive, "Concert does not exist");
        require(concerts[_id].soldTickets < concerts[_id].totalTickets, "All tickets are sold out");
        require(msg.value == concerts[_id].price, "Invalid amount of Ether");
        _tokenIds.increment();
        uint256 newTicketId = _tokenIds.current();
        _safeMint(msg.sender, newTicketId);
        userTickets[msg.sender].push(newTicketId);
        concerts[_id].soldTickets += 1;
    }

    function getTickets(address _user) public view returns (uint256[] memory) {
        return userTickets[_user];
    }
}