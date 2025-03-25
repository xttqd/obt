// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Voting {
    mapping(bytes32 => uint256) public votesReceived;
    mapping(address => bool) public hasVoted;
    bytes32[] public candidateList;

    constructor() {
        candidateList.push(bytes32(unicode"Алиса"));
        candidateList.push(bytes32(unicode"Боб"));
        candidateList.push(bytes32(unicode"Вероника"));
        candidateList.push(bytes32(unicode"Галина"));
        candidateList.push(bytes32(unicode"Дмитрий"));
    }

    function totalVotesFor(bytes32 candidate) public view returns (uint256) {
        require(validCandidate(candidate), "Candidate not found!");
        return votesReceived[candidate];
    }

    function voteForCandidate(bytes32 candidate) public {
        require(validCandidate(candidate), "Candidate not found!");
        require(!hasVoted[msg.sender], "You have already voted!");
        
        votesReceived[candidate] += 1;
        hasVoted[msg.sender] = true;
    }

    function validCandidate(bytes32 candidate) public view returns (bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }

    function hasUserVoted(address user) public view returns (bool) {
        return hasVoted[user];
    }
}
