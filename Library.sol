// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract Library is Ownable { 

    LibraryUser[] public registeredLibraryUsers;

    mapping(address => LibraryUser) public addressToLibraryUser;

    mapping(uint => address[]) public bookIdToBorrowerAddresses;

    struct LibraryUser {
        address borrowerAddress;
        string name;
        bool isAlreadyBorrowingABook;
        bool isValidUser;
    }

    event UserCreated(address userAddress, string name);
    event UserBorrowedBook(uint bookId, string name, address userAddress);
    event UserReturnedBook(uint bookId, string name, address userAddress);

    function registerUser(string memory _name) public {
        require(!addressToLibraryUser[msg.sender].isValidUser);
        addressToLibraryUser[msg.sender] = LibraryUser(msg.sender, _name, false, true);

        emit UserCreated(msg.sender, _name);
    }

    function borrowBook(uint _bookId) public {
        require(addressToLibraryUser[msg.sender].isAlreadyBorrowingABook != true, "User can not borrow more than one copy of a book at a time!");
        require(bookIdToBook[_bookId].numberOfCopiesOverAll != 0, "User can not borrow a book more times than the available copies in the library!");
        
        addressToLibraryUser[msg.sender].isAlreadyBorrowingABook = true;
        bookIdToBook[_bookId].numberOfCopiesOverAll = --bookIdToBook[_bookId].numberOfCopiesOverAll;
        bookIdToBorrowerAddresses[_bookId].push(msg.sender);

        emit UserBorrowedBook(_bookId, bookIdToBook[_bookId].name, msg.sender);
    }

    function returnBook(uint _bookId) public {
        bookIdToBook[_bookId].numberOfCopiesOverAll = ++bookIdToBook[_bookId].numberOfCopiesOverAll;

        emit UserReturnedBook(_bookId, bookIdToBook[_bookId].name, msg.sender);
    }

    function viewPreviousBookBorrowersByBookId(uint _bookId) public view returns (address[] memory) {
        return bookIdToBorrowerAddresses[_bookId];
    }

    function viewAvailableBooks() public returns (Book[] memory) {
        uint arrayLength = availableBooks.length;
        
        for (uint i=0; i<arrayLength; i++) {
            if(availableBooks[i].numberOfCopiesOverAll == 0) {
                delete availableBooks[i];
            }
        }
        return availableBooks;
    }

}
