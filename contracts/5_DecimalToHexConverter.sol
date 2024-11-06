// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DecimalToHexConverter {
    // Функция для перевода десятичного числа в шестнадцатеричное представление
    function toHex(uint256 decimal) public pure returns (string memory) {
        require(decimal < 1000000, "The number must be six digits (0-999999)");

        // Если число равно 0, сразу возвращаем "0"
        if (decimal == 0) {
            return "0";
        }

        // Массив символов для шестнадцатеричных значений (0-9, A-F)
        bytes16 hexSymbols = "0123456789ABCDEF";

        // Временная строка для хранения результата
        string memory hexRepresentation = "";

        // Алгоритм преобразования в шестнадцатеричное представление
        while (decimal > 0) {
            // Определяем остаток от деления на 16
            uint256 remainder = decimal % 16;

            // Добавляем соответствующий символ в начало строки
            hexRepresentation = string(
                abi.encodePacked(hexSymbols[remainder], hexRepresentation)
            );

            // Делим число на 16
            decimal /= 16;
        }

        return hexRepresentation;
    }
}
