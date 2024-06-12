// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12 <0.9.0;

//0x5CD63e4F561c0C3ECB139d56376b2aEc832c5bE5
//0x157E453Bc488FFD2612892044896C68CEc8a76Fc
//0x2661D78C4bC38703F8fd12E88cb93282b2016b47

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// EmployeeStorage. It should not inherit from any other contracts
contract EmployeeStorage {
/*
State Variables
The contract should have the following state variables, optimized to minimize storage:
A private variable shares storing the employee's number of shares owned
Employees with more than 5,000 shares count as directors and are stored in another contract
Public variable name which stores the employee's name
A private variable salary storing the employee's salary
Salaries range from 0 to 1,000,000 dollars
A public variable idNumber storing the employee's ID number
Employee numbers are not sequential, so this field should allow any number up to 2^256-1
*/
uint16 private shares; 
uint24 private salary;
string public name;
uint public idNumber;
/*
Constructor
When deploying the contract, utilize the constructor to set:
shares
name
salary
idNumber
For the purposes of the test, you must deploy the contract with the following values:
shares - 1000
name - Pat
salary - 50000
idNumber - 112358132134
1000, "Pat", 50000, 112358132134
*/
    constructor(uint16 _shares, string memory _name,  uint24 _salary, uint _idNumber) {
      shares = _shares;
      name = _name;
		  salary = _salary;
		  idNumber = _idNumber;
    }

//Write a function called viewSalary that returns the value in salary.
	function viewSalary() external view returns (uint24){
		return salary;
	}
//Write a function called viewShares that returns the value in shares.
	function viewShares() external view returns (uint16){
		return shares;
	}
/*
Grant Shares
Add a public function called grantShares that increases the number of shares allocated to an employee by _newShares. It should:
Add the provided number of shares to the shares
If this would result in more than 5000 shares, revert with a custom error called TooManyShares that returns the number of shares the employee would have with the new amount added
If the number of _newShares is greater than 5000, revert with a string message, "Too many shares"
*/	
	error TooManyShares(uint16 _totalShares);
	function grantShares(uint16 _newshares) public {
		uint16 totalShares; 
		if (_newshares > 5000){
			revert("Too many shares");
		}
		//error called TooManyShares that returns the number of shares the employee would have with the new amount added
		totalShares = shares + _newshares;
		if (totalShares > 5000){
			revert TooManyShares(totalShares);
		}
		else
		{
			shares = totalShares;
		}
    return;
	}
	
/**
* Do not modify this function.  It is used to enable the unit test for this pin
* to check whether or not you have configured your storage variables to make
* use of packing.
*
* If you wish to cheat, simply modify this function to always return `0`
* I'm not your boss ¯\_(ツ)_/¯
*
* Fair warning though, if you do cheat, it will be on the blockchain having been
* deployed by your wallet....FOREVER!
*/
	function checkForPacking(uint _slot) public view returns (uint r) {
		assembly {
			r := sload (_slot)
		}
	}
}