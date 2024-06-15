// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12 <0.9.0;

// GarageManager. It should not inherit from any other contracts
contract GarageManager {
/*
A public mapping called garage to store a list of Cars (described below), indexed by address
*/

/*
Add the following types and functions.

Car Struct
Implement a struct called Car. It should store the following properties:
make
model
color
numberOfDoors
*/
struct Car {
    string make;
    string model;
    string color;
    uint numberofDoors;
}

mapping (address => Car[]) public garage;
address[] private addressesOfGarages;

/*
Add Car Garage
Add a function called addCar that adds a car to the user's collection in the garage. It should:
Use msg.sender to determine the owner
Accept arguments for make, model, color, and number of doors, and use those to create a new instance of Car
Add that Car to the garage under the user's address
*/
function addCar(string calldata make, string calldata model, string calldata color, uint numberofDoors) public {
	Car memory car = Car({
		make: make,
		model: model,
		color: color,
		numberofDoors: numberofDoors
	});
	garage[msg.sender].push(car);
	addressesOfGarages.push(msg.sender); 
}

/*
Get All Cars for the Calling User
Add a function called getMyCars. It should return an array with all of the cars owned by the calling user.
*/
function getMyCars() external view returns(Car[] memory) {
	return garage[msg.sender];
}

/*
Get All Cars for Any User
Add a function called getUserCars. It should return an array with all of the cars for any given address.
*/
function getUserCars(address sender) external view returns(Car[] memory) {
	return garage[sender];
}

/*Update Car
Add a function called updateCar. It should accept a uint for the index of the car to be updated, and arguments for all of the Car types.
If the sender doesn't have a car at that index, it should revert with a custom error BadCarIndex and the index provided.
Otherwise, it should update that entry to the new properties.
*/
error BadCarIndex(uint index);
function updateCar(uint index, string calldata make, string calldata model, string calldata color, uint8 numberofDoors) public {
	if (garage[msg.sender][index].numberofDoors <= 0) {
		revert BadCarIndex(index);
	} else {
		//Car memory car = new Car;
		//car.make = make;
		//car.model = model;
		//car.color = color;
		//car.numberofDoors = numberofDoors;
		garage[msg.sender][index].make = make;
		garage[msg.sender][index].model = model;
		garage[msg.sender][index].color = color;
		garage[msg.sender][index].numberofDoors = numberofDoors;
	}
}

/*
Reset My Garage
Add a public function called resetMyGarage. It should delete the entry in garage for the sender.
*/
function resetMyGarage() public {
	delete garage[msg.sender];
}
}