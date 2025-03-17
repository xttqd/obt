// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract DecimalToHexConverter {
    function toHex(uint256 decimal) public pure returns (string memory) {
        require(decimal < 1000000, "The number must be six digits (0-999999)");
        
        if (decimal == 0) {
            return "0";
        }

        bytes16 hexSymbols = "0123456789ABCDEF";
        string memory hexRepresentation = "";

        while (decimal > 0) {
            uint256 remainder = decimal % 16;
            hexRepresentation = string(
                abi.encodePacked(hexSymbols[remainder], hexRepresentation)
            );
            decimal /= 16;
        }
        return hexRepresentation;
    }
}
