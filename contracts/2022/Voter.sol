// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Voter {
  struct Candidate {
    uint id;
    string name;
    uint totalVoters;
  }

  mapping(address => bool) private voters;
  mapping(uint => Candidate) public candidates;
  uint private Count;

  event votedEvent (
    uint indexed candidateId
  );

  function addCandidate (string memory new_name) public {
    Count++;
    candidates[Count] = Candidate(Count, new_name, 0);
  }

  function vote (uint candidateId) public {
    require(!voters[msg.sender]);
    require(candidateId > 0 && candidateId <= Count);
    voters[msg.sender] = true;
    candidates[candidateId].totalVoters++;
    emit votedEvent(candidateId);
  }
  
}
