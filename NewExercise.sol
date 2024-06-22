// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12 <0.9.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
AddressBookFactory
The AddressBookFactory contains one function, deploy. It creates an instance of AddressBook
 and assigns the caller as the owner of that instance. It then returns the address of the
 newly-created contract.
*/
contract AddressBookFactory {

function deploy(uint _id) external returns (address NewAddressBook){
	AddressBook newAddressBook = new AddressBook();
    newAddressBook.transferOwnership(msg.sender);
    return newAddressBook;
}

}
/*
Build a contract that can deploy copies of an address book contract on demand, which allows users to add, remove, and view their contacts.

You'll need to develop two contracts for this exercise and import at least one additional contract.
Imported Contracts
Review the Ownable contract from OpenZeppelin. You'll need to use it to solve this exercise.

You may wish to use another familiar contract to help with this challenge.
*/

contract AddressBook{
/*
Create an Ownable contract called AddressBook. In it include:
A struct called Contact with properties for:
id
firstName
lastName
a uint array of phoneNumbers
Additional storage for contacts
Any other necessary state variables
*/

struct Contact{
	uint id;
	string firstName;
	string lastName;
	uint[] phoneNumbers;
	string additionalStorage;
}

Contact[] private contacts;
//mapping (uint => Contact) contacts;
mapping (uint => uint) private idToIndex;

uint private nextId = 1;

/*
It should include the following functions:
Add Contact
The addContact function should be usable only by the owner of the contract. It should 
take in the necessary arguments to add a given contact's information to contacts.
*/
function addContact(string calldata _firstName , string calldata _lastName, uint[] calldata phoneNumbers, string calldata additionalStorage) external onlyOwner{
	Contact memory contact = Contact({
		firstName: _firstName,
		lastName: _lastName,
		phoneNumbers: _phoneNumbers,
		additionalStorage: _additionalStorage
	});
	//contacts[msg.sender].push(contact);
	
	idToIndex[nextId] = contacts.length - 1;
    nextId++;
	
	addressesOfContacts.push(msg.sender); 

}
/*
Delete Contact
The deleteContact function should be usable only by the owner and should delete the contact under the supplied _id number.
If the _id is not found, it should revert with an error called ContactNotFound with the supplied id number.
*/
error ContactNotFound(uint id);
function deleteContact  (uint _id) external onlyOwner{
	uint index = idToIndex[id];
    // Check if the index is valid and if the contact with the provided ID exists
    if (index >= contacts.length || contacts[index].id != id) revert ContactNotFound(id);

    
}
/*
Get Contact
The getContact function returns the contact information of the supplied _id number. It reverts with ContactNotFound if the contact isn't present.
*/
function getContact(uint _id) external returns (Contact memory){
    uint index = idToIndex(_id);
	// Check if the index is valid and if the contact with the provided ID exists
    if (index >= contacts.length || contacts[index].id != id) revert ContactNotFound(id);

	return contacts(index);
}
/*
QUESTION
For bonus points (that only you will know about), explain why we can't just use the automatically generated getter for contacts?
--Because it would get the properties 1 by 1.

Get All Contacts
The getAllContacts function returns an array with all of the user's current, non-deleted contacts.
CAUTION
You shouldn't use onlyOwner for the two get functions. Doing so won't prevent a third party 
from accessing the information, because all information on the blockchain is public. 
However, it may give the mistaken impression that information is hidden, 
which could lead to a security incident.
*/
function getAllContacts() external returns (Contact[] memory){
	return contacts;
}

}