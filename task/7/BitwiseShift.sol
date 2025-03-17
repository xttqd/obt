// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract BitwiseShift {
    function toBinaryString(uint256 number) public pure returns (string memory) {
        if (number == 0) {
            return "0";
        }
        uint256 temp = number;
        uint256 length = 0;
        
        while (temp > 0) {
            length++;
            temp >>= 1;
        }
        
        bytes memory result = new bytes(length);
        for (uint256 i = 0; i < length; i++) {
            result[length - i - 1] = (number & 1 == 1) ? bytes1(0x31) : bytes1(0x30);
            number >>= 1;
        }
        return string(result);
    }

    function shiftLeft(string memory binaryNumber, uint256 positions) public pure returns (string memory) {
        uint256 number = binaryStringToUint(binaryNumber);
        uint256 result = number << positions;
        return toBinaryString(result);
    }

    function shiftRight(string memory binaryNumber, uint256 positions) public pure returns (string memory) {
        uint256 number = binaryStringToUint(binaryNumber);
        uint256 result = number >> positions;
        return toBinaryString(result);
    }

    function binaryStringToUint(string memory binary) public pure returns (uint256 result) {
        bytes memory b = bytes(binary);
        uint256 len = b.length;
        for (uint256 i = 0; i < len; i++) {
            uint256 digit = uint256(uint8(b[i])) - 48;
            result |= digit << (len - 1 - i);
        }
    }
}
