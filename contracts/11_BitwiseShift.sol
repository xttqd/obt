// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BitwiseShift {
    // Функция для выполнения побитового сдвига влево
    function shiftLeft(uint256 number, uint256 positions)
        public
        pure
        returns (uint256)
    {
        return number << positions;
    }

    // Функция для выполнения побитового сдвига вправо
    function shiftRight(uint256 number, uint256 positions)
        public
        pure
        returns (uint256)
    {
        return number >> positions;
    }
}
