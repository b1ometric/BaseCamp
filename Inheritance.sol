// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12 <0.9.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// employee. It should not inherit from any other contracts
abstract contract employee {
/*
Employee
Create an abstract contract called employee. It should have:
A public variable storing idNumber
A public variable storing managerId
A constructor that accepts arguments for and sets both of these variables
A virtual function called getAnnualCost that returns a uint
*/
	uint public idNumber;
	uint public managerId;

	constructor(uint _idNumber, uint _managerId){
		idNumber = _idNumber;
		managerId = _managerId;
	}

    function getAnnualCost() virtual public returns(uint);
}

/*
Salaried
A contract called Salaried. It should:
Inherit from Employee
Have a public variable for annualSalary
Implement an override function for getAnnualCost that returns annualSalary
An appropriate constructor that performs any setup, including setting annualSalary
*/
contract Salaried is employee {
	uint public annualSalary;
    function getAnnualCost() override view public returns(uint){
        return annualSalary;
    }
	
    constructor(uint _annualSalary, uint _idNumber, uint _managerId) employee(_idNumber, _managerId){
		annualSalary = _annualSalary;
	}
}

/*
Hourly
Implement a contract called Hourly. It should:
Inherit from Employee
Have a public variable storing hourlyRate
Include any other necessary setup and implementation
TIP
The annual cost of an hourly employee is their hourly rate * 2080 hours.
*/
contract Hourly is employee {
	uint public hourlyRate;
	function getAnnualCost() override view public returns (uint annualSalary) {
        return (hourlyRate * 2080);
    }
	constructor(uint _hourlyRate, uint _idNumber, uint _managerId) employee(_idNumber, _managerId){
		hourlyRate = _hourlyRate;
    }
}

/*
Manager
Implement a contract called Manager. It should:
Have a public array storing employee Ids
Include a function called addReport that can add id numbers to that array
Include a function called resetReports that can reset that array to empty
*/
contract Manager is Salaried {
	uint[] public employeeIds;
	function addReport(uint employeeId) public{
		employeeIds.push(employeeId);
	}	
	function resetReports() public{
		delete employeeIds;
	}
    constructor(uint _annualSalary, uint _idNumber, uint _managerId) Salaried(_annualSalary, _idNumber, _managerId){
    }
}

/*
Salesperson
Implement a contract called Salesperson that inherits from Hourly.
*/
contract Salesperson is Hourly {
    constructor(uint _hourlyRate, uint _idNumber, uint _managerId) Hourly(_hourlyRate, _idNumber, _managerId) {
    }
}

/*
Engineering Manager
Implement a contract called EngineeringManager that inherits from Salaried and Manager.
*/
contract EngineeringManager is Salaried, Manager {
    constructor(uint _annualSalary, uint _idNumber, uint _managerId) Manager(_annualSalary, _idNumber, _managerId){
    }
}

/*
Deployments
You'll have to do a more complicated set of deployments for this exercise.
Deploy your Salesperson and EngineeringManager contracts. Use the following values:

Salesperson
Hourly rate is 20 dollars an hour
Id number is 55555
Manager Id number is 12345
20, 55555, 12345

Manager
Annual salary is 200,000
Id number is 54321
Manager Id is 11111

Inheritance Submission
Copy the below contract and deploy it using the addresses of your Salesperson and EngineeringManager contracts.
0xF3bBf372E2FC5E3C7b36561C68e65212818965Fc, 0xF03391A14190eD435D7D7348eEbf66761E502FD2
*/
contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}
