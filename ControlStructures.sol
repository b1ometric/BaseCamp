// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

//0x4d174c3441988c0da938550696c70fDc76F77c73

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// ControlStructures. It should not inherit from any other contracts and does not need a constructor. 
contract ControlStructures {

/*
Create a function called fizzBuzz that accepts a uint called _number and returns a string memory. The function should return:
"Fizz" if the _number is divisible by 3
"Buzz" if the _number is divisible by 5
"FizzBuzz" if the _number is divisible by 3 and 5
"Splat" if none of the above conditions are true
*/
    function fizzBuzz(uint _number) external pure returns(string memory) {
	if (_number == 0){
		return "Splat";
	}
	if (_number % 3 == 0){
		if (_number % 5 == 0){
			return "Fizzbuzz";
		} else {
			return "Fizz";
		}
	} else {
		if (_number % 5 == 0){
			return "Buzz";
		}
	}
		return "Splat";
	}

/*
Do Not Disturb
Create a function called doNotDisturb that accepts a uint called _time, and returns a string memory. It should adhere to the following properties:
If _time is greater than or equal to 2400, trigger a panic
If _time is greater than 2200 or less than 800, revert with a custom error of AfterHours, and include the time provided
If _time is between 1200 and 1259, revert with a string message "At lunch!"
If _time is between 800 and 1199, return "Morning!"
If _time is between 1300 and 1799, return "Afternoon!"
If _time is between 1800 and 2200, return "Evening!"
*/
    error AfterHours(uint _time);
	function doNotDisturb(uint _time) external pure returns(string memory) {
		assert(_time < 2400);
		if (_time < 800 || _time > 2200){
			revert AfterHours(_time);
		}
		if (_time < 1200){
			return "Morning!";
		}
		if (_time < 1800){
			return "Afternoon!";
		}
		return "Evening!";
	}
}