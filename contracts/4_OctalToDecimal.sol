// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract OctalToDecimal {
    function octalToDecimal(string memory octal) public pure returns (uint) {
        require(bytes(octal).length <= 8, "Input must be 8 digits or less");
        
        uint result = 0;
        bytes memory octalBytes = bytes(octal);
        
        for (uint i = 0; i < octalBytes.length; i++) {
            require(
                uint8(octalBytes[i]) >= 48 && uint8(octalBytes[i]) <= 55,
                "Invalid octal digit"
            );
            
            uint digit = uint8(octalBytes[i]) - 48;  // Convert ASCII to number
            result = result * 8 + digit;
        }
        
        return result;
    }
} 