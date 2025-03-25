// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract BinaryToDecimal {
    function binaryToDecimal(string memory binary) public pure returns (uint) {
        require(bytes(binary).length <= 16, "Input must be 16 bits or less");
        
        uint result = 0;
        bytes memory binaryBytes = bytes(binary);
        
        for (uint i = 0; i < binaryBytes.length; i++) {
            require(binaryBytes[i] == '0' || binaryBytes[i] == '1', "Invalid binary digit");
            
            if (binaryBytes[i] == '1') {
                result += 2 ** (binaryBytes.length - 1 - i);
            }
        }
        
        return result;
    }
} 