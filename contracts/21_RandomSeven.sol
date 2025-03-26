// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract RandomSeven {
    function Random(uint x) public pure returns (string memory) {
        while (x > 0) {
            if (x % 10 == 7) {
                return "Winner";
            }
            x = x / 10;
        }
        return "Looser";
    }
}
