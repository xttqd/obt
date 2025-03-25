// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

import "./DragonFarm.sol";

contract DragonForge is DragonFarm {
    function Reforge(string memory name, uint id, uint food) public payable {
        require(msg.value > 0, "Banana for you!");
        uint brains = uint(keccak256(abi.encode(food)));
        brains = brains % (10 ** 16);
        uint newDna = (id + brains) / 2;
        
        // Create new dragon with the same ID
        dragons[id] = Dragon(id, name, newDna);
        DragonOwner[id] = msg.sender;
        ownerDragons[msg.sender]++;
    }
}
