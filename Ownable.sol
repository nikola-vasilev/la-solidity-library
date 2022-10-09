// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Ownable {

    uint bookIdDigits = 8;
    uint bookIdModulus = 10 ** bookIdDigits; 

    address public owner;

    Book[] public availableBooks;
    
    mapping(uint => Book) public bookIdToBook;

    mapping(address => uint) public borrowerAddressToBookId;

    event BookAdded(uint bookId, string name, address userAddress);

    struct Book {
        uint id;
        string name;
        uint16 numberOfCopiesOverAll;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender, "Not invoked by the owner");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }

    function addBook(string memory _name, uint16 numberOfCopies) public onlyOwner returns (uint) {
        uint id = _generateRandomBookId(_name);
        Book memory book = Book(id, _name, numberOfCopies);
        availableBooks.push(book);
        bookIdToBook[id] = book;

        emit BookAdded(id, _name, msg.sender);

        return id;
    }

    function _generateRandomBookId(string memory _name) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_name)));
        return rand % bookIdModulus;
    }

}
