// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

import "./25_DragonFarm.sol";
contract DragonForge is DragonFarm {
    function Reforge(string memory name, uint id, uint food) public payable {
        require(msg.value > 0, "Thanck you for food!");
        uint brains = uint(keccak256((abi.encode(food))));
        brains = brains % (10 ** 16);
        uint newDna = (id + brains) / 2;
        dragons.push(Dragon(id, name, newDna));
    }
}
