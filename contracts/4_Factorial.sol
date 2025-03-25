// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Factorial {
    function getFactorial(uint n) public pure returns (uint256) {
        uint256 f = 1;
        for (uint i = 1; i <= n; i++) {
            f = f * i;
        }
        return f;
    }
} 