// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12 <0.9.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract UnburnableToken {
    mapping(address => uint256) public balances; // Mapping to store how many tokens are owned by each address
    uint256 public totalSupply; // Total supply of tokens
    uint256 public totalClaimed; // Total number of tokens claimed
    mapping(address => bool) private claimed; // Mapping to track whether an address has claimed tokens

    // Custom errors
    error TokensClaimed(); // Error for attempting to claim tokens again
    error AllTokensClaimed(); // Error for attempting to claim tokens when all are already claimed
    error UnsafeTransfer(address _to); // Error for unsafe token transfer

    constructor() {
        totalSupply = 100000000;
    }

    function claim() public {
        if (totalClaimed >= totalSupply) revert AllTokensClaimed();
        
        if (claimed[msg.sender]) revert TokensClaimed();

        balances[msg.sender] += 1000;
        totalClaimed += 1000;
        claimed[msg.sender] = true;
    }

    function safeTransfer(address _to, uint256 _amount) public {
        // Check for unsafe transfer conditions, burn address, or the target address has a zero balance
        if (_to == address(0) || _to.balance == 0) revert UnsafeTransfer(_to);

        // Ensure the sender has enough balance to transfer
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}