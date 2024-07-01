// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract BasicMath {
/*A function called adder. It must:
Accept two uint arguments, called _a and _b, Return a uint sum and a bool error
If _a + _b do not overflow, it should return the sum and an error of false
If _a + _b overflow, it should return 0 as the sum, and an error of true
*/
    function adder(uint _a, uint _b) external pure returns(uint, bool) {
	
	unchecked{
		uint sum = (_a + _b);
		if (sum < _a || sum < _b){
			return (0, true);
		}
		else {
			return (sum, false);
		}
	}
    }

/*A function called subtractor. It must
Accept two uint arguments, called _a and _b, Return a uint difference and a bool error
If _a - _b does not underflow, it should return the difference and an error of false
If _a - _b underflows, it should return 0 as the difference, and an error of true
*/
    function subtractor(uint _a, uint _b) external pure returns(uint, bool) {
	unchecked {
		uint difference = (_a - _b);
		if (_a < _b) {
			return (0, true);
		}	
		else {
			return (difference, false);
		}
	}
    }
}
