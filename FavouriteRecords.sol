// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12 <0.9.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// FavouriteRecords. It should not inherit from any other contracts
contract FavouriteRecords {

/*
State Variables
The contract should have the following state variables. It is up to you to decide if any supporting variables are useful.

A public mapping approvedRecords, which returns true if an album name has been added as described below, and false if it has not
A mapping called userFavorites that indexes user addresses to a mapping of string record names which returns true or false, depending if the user has marked that album as a favorite
*/

	mapping (string => bool) public approvedRecords;
	mapping (address => string[]) public userFavorites;
	address[] private addressesOfUserFavourites;
	string[] private approvedRecordsArray;
/*
Loading Approved Albums
Using the method of your choice, load approvedRecords with the following:

"Thriller", "Back in Black", "The Bodyguard", "The Dark Side of the Moon", "Their Greatest Hits (1971-1975)", "Hotel California", "Come On Over", "Rumours, "Saturday Night Fever"
*/
//approvedRecords = ["Thriller", "Back in Black", "The Bodyguard", "The Dark Side of the Moon", "Their Greatest Hits (1971-1975)", "Hotel California", "Come On Over", "Rumours", "Saturday Night Fever"];
	constructor() {
		 approvedRecords["Thriller"] = true;
		 approvedRecords["Back in Black"] = true;
		 approvedRecords["The Bodyguard"] = true;
		 approvedRecords["The Dark Side of the Moon"] = true;
		 approvedRecords["Their Greatest Hits (1971-1975)"] = true;
		 approvedRecords["Hotel California"] = true;
		 approvedRecords["Come On Over"] = true;
		 approvedRecords["Rumours"] = true;
		 approvedRecords["Saturday Night Fever"] = true;

	         approvedRecordsArray.push("Thriller");
	         approvedRecordsArray.push("Back in Black");
	         approvedRecordsArray.push("The Bodyguard");
	         approvedRecordsArray.push("The Dark Side of the Moon");
	         approvedRecordsArray.push("Their Greatest Hits (1971-1975)");
	         approvedRecordsArray.push("Hotel California");
	         approvedRecordsArray.push("Come On Over");
	         approvedRecordsArray.push("Rumours");
	         approvedRecordsArray.push("Saturday Night Fever");
	}

/*
Get Approved Records
Add a function called getApprovedRecords. This function should return a list of 
all of the names currently indexed in approvedRecords.
*/
	function getApprovedRecords() external view returns (string[] memory){
		uint cursor = 0;
		uint resultsLength = _countFavouriteRecords();
		
		string[] memory tempApprovedRecords = new string[](resultsLength);
		for (uint i=0; i < approvedRecordsArray.length; i++){
			if (approvedRecords[approvedRecordsArray[i]] == true){
				//_approvedRecords[cursor] = approvedRecordsArray[i];
				tempApprovedRecords[cursor] = approvedRecordsArray[i];
				cursor++;
			}
		}
		//return _approvedRecords;
		return tempApprovedRecords;
	}	

	function _countFavouriteRecords() internal view returns(uint) {
	    uint result = 0;
	
	    for(uint i = 0; i < approvedRecordsArray.length; i++) {
	        if(approvedRecords[approvedRecordsArray[i]] == true) {
	            result++;
	        }
	    }
	    return result;
	}

/*
Add Record to Favorites
Create a function called addRecord that accepts an album name as a parameter. 
If the album is on the approved list, add it to the list under the address of 
the sender. Otherwise, reject it with a custom error of NotApproved with the 
submitted name as an argument.
*/
	error NotApproved(string _albumName);
	function addRecord(string memory _albumName) external {
		 
        if (approvedRecords[_albumName] = true){
			userFavorites[msg.sender].push(_albumName);
			// Imperfect solution, see below
			addressesOfUserFavourites.push(msg.sender);
		} else {
			revert NotApproved(_albumName);
		}	
	}
/*
Users' Lists
Write a function called getUserFavorites that retrieves the list of favorites 
for a provided address memory.
*/
	function getUserFavorites(address sender) external view returns(string[] memory) {
		return userFavorites[sender];
	}

/*
Reset My Favorites
Add a function called resetUserFavorites that resets userFavorites for the sender.
*/
	function resetUserFavorites() external {
		delete userFavorites[msg.sender];
	}

}
