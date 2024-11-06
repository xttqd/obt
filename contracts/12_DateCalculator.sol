// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DateCalculator {
    uint256 constant SECONDS_IN_A_DAY = 86400;

    // Функция для вычисления разницы между двумя датами (в днях)
    function dateDifference(uint256 timestamp1, uint256 timestamp2)
        public
        pure
        returns (uint256)
    {
        require(
            timestamp1 <= timestamp2,
            "The first argument must be less than or equal to the second"
        );
        return (timestamp2 - timestamp1) / SECONDS_IN_A_DAY;
    }

    // Функция для добавления дней к дате
    function addDays(uint256 timestamp, uint256 numDays)
        public
        pure
        returns (uint256)
    {
        return timestamp + (numDays * SECONDS_IN_A_DAY);
    }

    // Функция для вычитания дней из даты
    function subtractDays(uint256 timestamp, uint256 numDays)
        public
        pure
        returns (uint256)
    {
        require(
            timestamp >= numDays * SECONDS_IN_A_DAY,
            "The result cannot be negative"
        );
        return timestamp - (numDays * SECONDS_IN_A_DAY);
    }
}
