// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Calculator {
    int256 public result;

    function calculate(
        int256 x,
        int256 y,
        string memory oper
    ) public returns (int256) {
        if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("+"))
        ) {
            result = x + y;
        } else if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("-"))
        ) {
            result = x - y;
        } else if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("*"))
        ) {
            result = x * y;
        } else if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("/"))
        ) {
            require(y != 0, "Division by zero");
            result = x / y;
        } else {
            revert("Invalid operation");
        }
        return result;
    }
}
