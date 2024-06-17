// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12 <0.9.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

library SillyStringUtils {

    struct Haiku {
        string line1;
        string line2;
        string line3;
    }

    function shruggie(string memory _input) internal pure returns (string memory) {
        return string.concat(_input, unicode" ??");
    }
}

//Create a contract calle[d ImportsExercise. It should import a copy of SillyStringUtils
contract ImportsExercise {
//Add a public instance of Haiku called haiku.
	using SillyStringUtils for SillyStringUtils.Haiku;
    //Haiku public haiku; 
    SillyStringUtils.Haiku public haiku;
//Add the following two functions.
//Save Haiku
//saveHaiku should accept three strings and save them as the lines of haiku.
function saveHaiku(string memory _line1, string memory _line2, string memory _line3) external {
	haiku.line1 = _line1;
	haiku.line2 = _line2;
	haiku.line3 = _line3;
}

//Get Haiku
//getHaiku should return the haiku as a Haiku type.
function getHaiku() external view returns (SillyStringUtils.Haiku memory) { 
	return haiku;
}

//INFO
//Remember, the compiler will automatically create a getter for public structs, but these 
//return each member individually. Create your own getters to return the type.

//Shruggie Haiku
//shruggieHaiku should use the library to add ?? to the end of line3. It must not modify 
//the original haiku. It should return the modified Haiku.
function shruggieHaiku() external view returns(SillyStringUtils.Haiku memory){
	SillyStringUtils.Haiku memory newHaiku;
    newHaiku = haiku;
    newHaiku.line3 = SillyStringUtils.shruggie(haiku.line3);
    return newHaiku;
}
}