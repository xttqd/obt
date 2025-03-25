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
    mapping (address => uint) public ownerDragons;

    function GenerateRandomDna(string memory str) internal pure returns (uint) {
        uint rand = uint(keccak256(abi.encode(str)));
        return rand % (10 ** 16);
    }

    function CreateDragon(string memory name) public {
        uint dna = GenerateRandomDna(name);
        uint id = dragons.length;
        dragons.push(Dragon(id, name, dna));
        DragonOwner[id] = msg.sender;
        ownerDragons[msg.sender]++;
        emit NewDragon(id, name, dna);
    }
}
