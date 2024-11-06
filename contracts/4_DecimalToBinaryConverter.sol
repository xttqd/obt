// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DecimalToBinaryConverter {
    // Функция для перевода десятичного числа в двоичное представление
    function toBinary(uint256 decimal) public pure returns (string memory) {
        require(decimal < 1000000, "The number must be six digits (0-999999)");

        // Временная строка для хранения результата
        string memory binaryRepresentation = "";

        // Если число равно 0, сразу возвращаем "0"
        if (decimal == 0) {
            return "0";
        }

        // Алгоритм преобразования в двоичное представление
        while (decimal > 0) {
            // Определяем остаток от деления на 2 (0 или 1)
            uint256 remainder = decimal % 2;

            // Добавляем остаток в начало строки (конкатенация)
            binaryRepresentation = string(
                abi.encodePacked(
                    remainder == 1 ? "1" : "0",
                    binaryRepresentation
                )
            );

            // Делим число на 2
            decimal /= 2;
        }

        return binaryRepresentation;
    }
}
