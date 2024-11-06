// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BitwiseCalculator {
    uint8 public result;

    function calculate(
        uint8 a,
        uint8 b,
        string memory oper
    ) public returns (uint8) {
        require(a < 256 && b < 256, "Inputs must be 8-bit numbers (0-255)");

        if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("AND"))
        ) {
            result = a & b;
        } else if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("OR"))
        ) {
            result = a | b;
        } else {
            revert("Invalid operation");
        }

        return result;
    }

    function notOperation(uint8 a) public returns (uint8) {
        require(a < 256, "Input must be an 8-bit number (0-255)");
        result = ~a & 0xFF; // Оставляем только 8 бит
        return result;
    }
}
