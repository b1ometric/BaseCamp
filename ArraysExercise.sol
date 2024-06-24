// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// ArraysExercise. It should not inherit from any other contracts
contract ArraysExercise {
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];

/*
Return a Complete Array
The compiler automatically adds a getter for individual elements in the array, but it does not automatically provide functionality to retrieve the entire array.
Write a function called getNumbers that returns the entire numbers array.
*/
	function getNumbers() public view returns (uint[] calldata){
		return numbers;
	}

/*
Reset Numbers
Write a public function called resetNumbers that resets the numbers array to its initial value, holding the numbers from 1-10.
NOTE
We'll award the pin for any solution that works, but one that doesn't use .push() is more gas-efficient!
CAUTION
Remember, anyone can call a public function! You'll learn how to protect functionality in another lesson.
*/
	function resetNumbers() public {
		numbers = [1,2,3,4,5,6,7,8,9,10];
	}

/*
Append to an Existing Array
Write a function called appendToNumbers that takes a uint[] calldata array called _toAppend, and adds that array to the storage array called numbers, already present in the starter.
*/
	function appendToNumbers(uint[] calldata _toAppend){
		for (uint i=0; i< _toAppend.length; i++){
			numbers.push(_toAppend[i]);
		}
	}

/*
Timestamp Saving
At the contract level, add an address array called senders and a uint array called timestamps.
*/
	address[] senders;
	uint[] timestamps;

*/
Write a function called saveTimestamp that takes a uint called _unixTimestamp as an argument. When called, it should add the address of the caller to the end of senders and the _unixTimeStamp to timestamps.
TIP
You'll need to research on your own to discover the correct Special Variables and Functions that can help you with this challenge!
*/
	function saveTimestamp(uint _unixTimestamp){
		senders.push(msg.payableAddress);
		timestamps.push(_unixTimestamp);
	}	

/*
Timestamp Filtering
Write a function called afterY2K that takes no arguments. When called, it should return two arrays.
The first should return all timestamps that are more recent than January 1, 2000, 12:00am. To save you a click, the Unix timestamp for this date and time is 946702800.
The second should return a list of senders addresses corresponding to those timestamps.
*/
	function afterY2K() returns (uint[] memory y2kTimestamps, uint[] memory y2kSenders){
		uint count = 0;
		for (uint i=0; i <timestamps.length; i++)
		{
			// need to get length upfront
			if (timestamps[i] > 946702800){
				count++;
			}
		}	
		//type>[] memory filteredArray = new <type>[](numX)
		uint[] memory _y2kTimestamps = new uint[](count);
		uint[] memory _y2kSenders = new uint[](count);
		uint cursor = 0;
		
		for (uint i=0; i <timestamps.length; i++)
		{
			if (timestamps[i] > 946702800){
				_y2kTimestamps[cursor] = timestamps[i];
				_y2kSenders[cursor] = senders[i];
				cursor++;
			}
		}
		return (_y2kTimestamps, _y2kSenders);
	}

/*
Resets
Add public functions called resetSenders and resetTimestamps that reset those storage variables.
*/
	function resetSenders(){
		delete senders;
	}

	function resetTimestamps(){
		delete timestamps;
	}
}
