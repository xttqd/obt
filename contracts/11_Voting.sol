// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Voting {
    mapping(bytes32 => uint256) public votesReceived;
    bytes32[] public candidateList;
    constructor(bytes32[] memory candidateNames) public {
        candidateList = candidateNames;
    }

    function totalVotesFor(bytes32 candidate) public view returns (uint256) {
        require(validCandidate(candidate), "Candidate bot found!");
        return votesReceived[candidate];
    }
    function voteForCandidate(bytes32 candidate) public {
        require(validCandidate(candidate), "Candidate bot found!");
        votesReceived[candidate] += 1;
    }
    function validCandidate(bytes32 candidate) public view returns (bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}
