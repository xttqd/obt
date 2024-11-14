// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Note {
    string public name;
    uint number;
    string public location;

    function set(string memory newName, uint newNumber, string memory newLocation) public {
        name = newName;
        number = newNumber;
        location = newLocation;
    }

    function get() public view returns (string memory, uint, string memory) {
        return (name, number, location);
    }
}