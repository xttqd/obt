// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BitwiseCalculatorAdvanced {
    uint8 public result;

    function calculate(
        uint8 a,
        uint8 b,
        string memory oper
    ) public returns (uint8) {
        require(a < 256 && b < 256, "Inputs must be 8-bit numbers (0-255)");

        if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("NAND"))
        ) {
            result = ~(a & b) & 0xFF; // NAND
        } else if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("NOR"))
        ) {
            result = ~(a | b) & 0xFF; // NOR
        } else if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("XOR"))
        ) {
            result = a ^ b; // XOR
        } else {
            revert("Invalid operation");
        }

        return result;
    }
}
