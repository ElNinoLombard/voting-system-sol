
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;

    uint[] public candidateIds;

    mapping(address => bool) public voters;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can perform this operation");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerCandidate(uint _id, string memory _name) public onlyOwner {
        require(candidates[_id].id == 0, "Candidate already exists");
        Candidate memory newCandidate = Candidate(_id, _name, 0);
        candidates[_id] = newCandidate;
        candidateIds.push(_id);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted");
        require(candidates[_candidateId].id != 0, "Candidate does not exist");
        candidates[_candidateId].voteCount++;
        voters[msg.sender] = true;
    }

    function getTotalCandidates() public view returns(uint) {
        return candidateIds.length;
    }
}
