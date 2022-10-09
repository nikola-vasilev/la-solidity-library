# la-solidity-library

author: Nikola Vasilev

Lime Academy week 0 task: Library

Consists of two contracts Ownable and Library.

Ownable has the check for admin user and the ability to add books (with the constraint of admin user).

Library has the functionality to register users, borrow and return a book, view available books and view previous book borrowers' adresses.


Requirements of the task:
- The administrator (owner) of the library should be able to add new books and the number of copies in the library.
- Users should be able to see the available books and borrow them by their id.
- Users should be able to return books.
- A user should not borrow more than one copy of a book at a time. The users should not be able to borrow a book more times than the copies in the libraries unless copy is returned.
- Everyone should be able to see the addresses of all people that have ever borrowed a given book.
