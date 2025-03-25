// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract DecimalToBinaryConverter {
    function toBinary(uint256 decimal) public pure returns (string memory) {
        require(decimal < 1000000, "The number must be six digits (0-999999)");

        if (decimal == 0) {
            return "0";
        }

        string memory binaryRepresentation = "";

        while (decimal > 0) {
            uint256 remainder = decimal % 2;
            binaryRepresentation = string(
                abi.encodePacked(
                    remainder == 1 ? "1" : "0",
                    binaryRepresentation
                )
            );
            decimal /= 2;
        }
        return binaryRepresentation;
    }
}
