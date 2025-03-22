// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract BitwiseCalculator {
    string public result;

    function binaryStringToUint8(string memory binaryString) internal pure returns (uint8) {
        bytes memory b = bytes(binaryString);
        require(b.length == 8, "Input must be an 8-bit binary string");

        uint8 num = 0;
        for (uint8 i = 0; i < 8; i++) {
            require(b[i] == '0' || b[i] == '1', "Invalid binary character");
            num = (num << 1) | (b[i] == '1' ? 1 : 0);
        }
        return num;
    }

    function uint8ToBinaryString(uint8 num) internal pure returns (string memory) {
        bytes memory binaryString = new bytes(8);
        for (uint8 i = 0; i < 8; i++) {
            binaryString[7 - i] = (num & (1 << i)) != 0 ? bytes1('1') : bytes1('0');
        }
        return string(binaryString);
    }

    function AND(string memory a, string memory b) public returns (string memory) {
        uint8 numA = binaryStringToUint8(a);
        uint8 numB = binaryStringToUint8(b);
        uint8 operationResult;
        operationResult = numA & numB;
        result = uint8ToBinaryString(operationResult);
        return result;
    }

    function OR(string memory a, string memory b) public returns (string memory) {
        uint8 numA = binaryStringToUint8(a);
        uint8 numB = binaryStringToUint8(b);
        uint8 operationResult;
        operationResult = numA | numB;
        result = uint8ToBinaryString(operationResult);
        return result;
    }

    function NOT(string memory a) public returns (string memory) {
        uint8 numA = binaryStringToUint8(a);
        uint8 operationResult = ~numA & 0xFF;

        result = uint8ToBinaryString(operationResult);
        return result;
    }
}
