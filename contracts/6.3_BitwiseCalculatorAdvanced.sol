// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract BitwiseCalculatorAdvanced {
    string public result;

    function binaryStringToUint8(string memory binaryString)
        internal
        pure
        returns (uint8)
    {
        bytes memory b = bytes(binaryString);
        require(b.length == 8, "Input must be an 8-bit binary string");

        uint8 num = 0;
        for (uint8 i = 0; i < 8; i++) {
            require(b[i] == "0" || b[i] == "1", "Invalid binary character");
            num = (num << 1) | (b[i] == "1" ? 1 : 0);
        }
        return num;
    }

    function uint8ToBinaryString(uint8 num)
        internal
        pure
        returns (string memory)
    {
        bytes memory binaryString = new bytes(8);
        for (uint8 i = 0; i < 8; i++) {
            binaryString[7 - i] = (num & (1 << i)) != 0
                ? bytes1("1")
                : bytes1("0");
        }
        return string(binaryString);
    }

    function calculate(
        string memory a,
        string memory b,
        string memory oper
    ) public returns (string memory) {
        uint8 numA = binaryStringToUint8(a);
        uint8 numB = binaryStringToUint8(b);
        uint8 operationResult;

        if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("NAND"))
        ) {
            operationResult = ~(numA & numB) & 0xFF;
        } else if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("NOR"))
        ) {
            operationResult = ~(numA | numB) & 0xFF;
        } else if (
            keccak256(abi.encodePacked(oper)) ==
            keccak256(abi.encodePacked("XOR"))
        ) {
            operationResult = numA ^ numB;
        } else {
            revert("Invalid operation");
        }

        result = uint8ToBinaryString(operationResult);
        return result;
    }
}
