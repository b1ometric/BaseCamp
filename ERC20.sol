// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.12 <0.9.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

// Contract for weighted voting using ERC20 token
contract WeightedVoting is ERC20 {
    using EnumerableSet for EnumerableSet.AddressSet; // Importing EnumerableSet for address set functionality

    // Custom errors
    error TokensClaimed(); // Error for attempting to claim tokens again
    error AllTokensClaimed(); // Error for attempting to claim tokens when all are already claimed
    error NoTokensHeld(); // Error for attempting to perform an action without holding tokens
    error QuorumTooHigh(uint256 _quorum); // Error for setting a quorum higher than total supply, returning the quorum amount proposed
    error AlreadyVoted(); // Error for attempting to vote more than once
    error VotingClosed(); // Error for attempting to vote on a closed issue

    // Struct to represent an issue
    struct Issue {
        EnumerableSet.AddressSet voters; // Set of voters
        string issueDesc; // Description of the issue
        uint256 quorum; // Quorum required to close the issue
        uint256 totalVotes; // Total number of votes casted
        uint256 votesFor; // Total number of votes for
        uint256 votesAgainst; // Total number of votes against
        uint256 votesAbstain; // Total number of abstained votes
        bool passed; // Boolean indicating if the issue passed
        bool closed; // Boolean indicating if the issue is closed
    }

    // Struct to represent a serialized issue
    struct SerializedIssue {
        address[] voters; // Array of voters
        string issueDesc; // Description of the issue
        uint256 quorum; // Quorum required to close the issue
        uint256 totalVotes; // Total number of votes casted
        uint256 votesFor; // Total number of votes for
        uint256 votesAgainst; // Total number of votes against
        uint256 votesAbstain; // Total number of abstained votes
        bool passed; // Boolean indicating if the issue passed
        bool closed; // Boolean indicating if the issue is closed
    }

    // Enum to represent different vote options
    enum Vote {
        AGAINST,
        FOR,
        ABSTAIN
    }

    // Array to store all issues
    Issue[] internal issues;

    // Mapping to track if tokens are claimed by an address
    mapping(address => bool) public tokensClaimed;

    uint256 public maxSupply = 1000000;
    uint256 public claimAmount = 100;

    // Constructor to initialize ERC20 token with a name and symbol
    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        issues.push(); // Pushing an empty issue to start from index 1
    }

    // Function to claim tokens
    function claim() public {
        // Check if all tokens have been claimed
        if (totalSupply() + claimAmount > maxSupply) {
            revert AllTokensClaimed();
        }
        // Check if the caller has already claimed tokens
        if (tokensClaimed[msg.sender]) {
            revert TokensClaimed();
        }
        // Mint tokens to the caller
        _mint(msg.sender, claimAmount);
        tokensClaimed[msg.sender] = true; // Mark tokens as claimed
    }

    // Function to create a new voting issue
    function createIssue(string calldata _issueDesc, uint256 _quorum) external returns (uint256) {
        // Check if the caller holds any tokens
        if (balanceOf(msg.sender) == 0) {
            revert NoTokensHeld();
        }
        // Check if the specified quorum is higher than total supply
        if (_quorum > totalSupply()) {
            revert QuorumTooHigh(_quorum);
        }
        // Create a new issue and return its index
        Issue storage _issue = issues.push();
        _issue.issueDesc = _issueDesc;
        _issue.quorum = _quorum;
        return issues.length - 1;
    }

    // Function to get details of a voting issue
    function getIssue(uint256 _issueId) external view returns (SerializedIssue memory) {
        Issue storage _issue = issues[_issueId];
        return
            SerializedIssue({
                voters: _issue.voters.values(),
                issueDesc: _issue.issueDesc,
                quorum: _issue.quorum,
                totalVotes: _issue.totalVotes,
                votesFor: _issue.votesFor,
                votesAgainst: _issue.votesAgainst,
                votesAbstain: _issue.votesAbstain,
                passed: _issue.passed,
                closed: _issue.closed
            });
    }

    // Function to cast a vote on a voting issue
    function vote(uint256 _issueId, Vote _vote) public {
        Issue storage _issue = issues[_issueId];

        if (_issue.closed) {
            revert VotingClosed();
        }
        if (_issue.voters.contains(msg.sender)) {
            revert AlreadyVoted();
        }

        uint256 nTokens = balanceOf(msg.sender);
        // Check if the caller holds any tokens
        if (nTokens == 0) {
            revert NoTokensHeld();
        }

        // Update vote counts based on the vote option
        if (_vote == Vote.AGAINST) {
            _issue.votesAgainst += nTokens;
        } else if (_vote == Vote.FOR) {
            _issue.votesFor += nTokens;
        } else {
            _issue.votesAbstain += nTokens;
        }

        // Add the caller to the list of voters and update total votes count
        _issue.voters.add(msg.sender);
        _issue.totalVotes += nTokens;

        // Close the issue if quorum is reached and determine if it passed
        if (_issue.totalVotes >= _issue.quorum) {
            _issue.closed = true;
            if (_issue.votesFor > _issue.votesAgainst) {
                _issue.passed = true;
            }
        }
    }
}