// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract DragonFarm {
  event NewDragon(uint id, string name, uint dna);
  struct Dragon {
    uint id;
    string name;
    uint dna;
  } 
  Dragon[] public dragons;
  mapping (uint => address) public DragonOwner;
  mapping (address => uint) ownerDragons;
  function GenerateRandomDna(string memory str) private pure returns (uint) {
    uint rand = uint(keccak256((abi.encode(str))));
    return rand % (10 ** 16);
  }
  /*function AddDragon(string memory _name, uint _dna) private {
    dragons.push(Dragon(_name, _dna));
    emit NewDragon(_name, _dna);
  }*/
  function CreateDragon(string memory name) public {
    uint dna = GenerateRandomDna(name);
    uint id = ownerDragons[msg.sender];
    dragons.push(Dragon(id, name, dna));
    DragonOwner[id] = msg.sender;
    emit NewDragon(id, name, dna);
    ownerDragons[msg.sender]++;
  }
}
