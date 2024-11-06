// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BaseConverter {
    // Массив символов для представления чисел в системе счисления до 16
    bytes16 symbols = "0123456789ABCDEF";

    // Функция для перевода десятичного числа в произвольную систему счисления
    function convertToBase(uint256 decimal, uint8 base)
        public
        view
        returns (string memory)
    {
        require(
            base >= 2 && base <= 16,
            "The number system must be from 2 to 16"
        );

        // Если число равно 0, сразу возвращаем "0"
        if (decimal == 0) {
            return "0";
        }

        // Временная строка для хранения результата
        string memory result = "";

        // Алгоритм преобразования в заданную систему счисления
        while (decimal > 0) {
            // Определяем остаток от деления на основание системы счисления
            uint256 remainder = decimal % base;

            // Добавляем соответствующий символ в начало строки
            result = string(abi.encodePacked(symbols[remainder], result));

            // Делим число на основание системы счисления
            decimal /= base;
        }

        return result;
    }
}
