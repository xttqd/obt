// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract NewNote {
    struct user {
        string name;
        uint number;
        string location;
    }

    mapping(string => user) public users;

    function setUser(string memory name, uint number, string memory location) public {
        users[name] = user(name, number, location);
    }

    function getUser(string memory name) public view returns(uint number, string memory location) {
        return (users[name].number, users[name].location);
    }
}