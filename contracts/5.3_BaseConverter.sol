// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract BaseConverter {
    bytes16 symbols = "0123456789ABCDEF";

    function convertBase(
        string memory num,
        uint8 basefrom,
        uint8 baseto
    ) public view returns (string memory) {
        require(
            basefrom >= 2 && basefrom <= 16,
            "The number system must be from 2 to 16"
        );
        require(
            baseto >= 2 && baseto <= 16,
            "The number system must be from 2 to 16"
        );
        uint256 decimal = convertToDecimal(num, basefrom);
        return convertFromDecimal(decimal, baseto);
    }

    function convertToDecimal(
        string memory num,
        uint8 basefrom
    ) internal pure returns (uint256) {
        uint256 decimal = 0;
        uint256 power = 1;

        bytes memory numBytes = bytes(num);
        for (uint256 i = numBytes.length; i > 0; i--) {
            uint8 digit = uint8(numBytes[i - 1]);

            if (digit >= 48 && digit <= 57) {
                digit -= 48;
            } else if (digit >= 65 && digit <= 70) {
                digit -= 55;
            } else {
                revert("Invalid character in input number");
            }

            require(digit < basefrom, "Digit out of range for basefrom");

            decimal += uint256(digit) * power;
            power *= basefrom;
        }

        return decimal;
    }

    function convertFromDecimal(
        uint256 decimal,
        uint8 baseto
    ) internal view returns (string memory) {
        if (decimal == 0) {
            return "0";
        }

        string memory result = "";

        while (decimal > 0) {
            uint256 remainder = decimal % baseto;
            result = string(abi.encodePacked(symbols[remainder], result));
            decimal /= baseto;
        }

        return result;
    }
}
