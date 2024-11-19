// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract DateCalculator {
    struct Date {
        uint256 year;
        uint256 month;
        uint256 day;
    }

    function _daysInMonth(
        uint256 month,
        uint256 year
    ) private pure returns (uint256) {
        uint8[12] memory daysInMonth = [
            31,
            28,
            31,
            30,
            31,
            30,
            31,
            31,
            30,
            31,
            30,
            31
        ];
        if (month == 2 && _isLeapYear(year)) {
            return 29; // Високосный февраль
        }
        return daysInMonth[month - 1];
    }

    function _isLeapYear(uint256 year) private pure returns (bool) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    function dateDifference(
        Date memory startDate,
        Date memory endDate
    ) public pure returns (int256 DaysDifference) {
        int256 startDays = _dateToDays(startDate);
        int256 endDays = _dateToDays(endDate);
        return endDays - startDays;
    }

    function addOrSubtractDays(
        Date memory date,
        int256 daysToAdd
    ) public pure returns (uint256 Year, uint256 Month, uint256 Day) {
        int256 totalDays = _dateToDays(date) + daysToAdd;
        require(
            totalDays >= 0,
            "Resulting date is before the start of the calendar"
        );
        Date memory sh = _daysToDate(uint256(totalDays));
        return (sh.year, sh.month, sh.day);
    }

    function _dateToDays(Date memory date) private pure returns (int256) {
        int256 totalDays = int256(date.day);

        for (uint256 i = 1; i < date.month; i++) {
            totalDays += int256(_daysInMonth(i, date.year));
        }

        totalDays += int256((date.year - 1) * 365);
        totalDays += int256((date.year - 1) / 4);
        totalDays -= int256((date.year - 1) / 100);
        totalDays += int256((date.year - 1) / 400);

        return totalDays;
    }

    function _daysToDate(uint256 totalDays) private pure returns (Date memory) {
        uint256 year = (totalDays * 400) / 146097;
        uint256 startOfYearDays = uint256(_dateToDays(Date(year, 1, 1)));

        require(
            totalDays >= startOfYearDays,
            "Days out of range for the given year"
        );

        uint256 daysLeft = totalDays - startOfYearDays;

        while (daysLeft >= 365 + (_isLeapYear(year) ? 1 : 0)) {
            daysLeft -= 365 + (_isLeapYear(year) ? 1 : 0);
            year++;
        }

        uint256 month = 1;
        for (uint256 i = 1; i <= 12; i++) {
            uint256 daysInCurrentMonth = _daysInMonth(i, year);

            if (daysLeft < daysInCurrentMonth) {
                break;
            }

            daysLeft -= daysInCurrentMonth;
            month++;
        }

        uint256 day = daysLeft + 1;

        return Date(year, month, day);
    }
}
