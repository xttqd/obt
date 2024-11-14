// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

import "./SaveMath.sol";

contract BanckDeposit {
    using SaveMath for uint;

    mapping(address => uint) public userDeposit;
    mapping(address => uint) public balance;
    mapping(address => uint) public time;
    mapping(address => uint) public percentWithdraw;
    mapping(address => uint) public allPercentWithdraw;
    uint public stepTime = 0.05 hours;

    event Invest(address investor, uint256 amount);
    event Withdraw(address investor, uint256 amount);

    modifier userExist() {
        require(balance[msg.sender] > 0, "Klient not found!");
        _;
    }

    modifier checkTime() {
        require(
            block.timestamp >= time[msg.sender].add(stepTime),
            "Very fast!"
        );
        _;
    }

    function banckAccount() public payable {
        require(msg.value >= .001 ether);
    }

    function collectPercent() public userExist checkTime {
        if ((balance[msg.sender].nul(2)) <= allPercentWithdraw[msg.sender]) {
            balance[msg.sender] = 0;
            time[msg.sender] = 0;
            percentWithdraw[msg.sender] = 0;
        } else {
            uint payout = payoutAmount();
            percentWithdraw[msg.sender] = percentWithdraw[msg.sender].add(
                payout
            );
            allPercentWithdraw[msg.sender] = allPercentWithdraw[msg.sender].add(
                payout
            );
            payable(msg.sender).transfer(payout);
            emit Withdraw(msg.sender, payout);
        }
    }

    function deposit() public payable {
        if (msg.value > 0) {
            if (
                balance[msg.sender] > 0 &&
                block.timestamp > time[msg.sender].add(stepTime)
            ) {
                collectPercent();
                percentWithdraw[msg.sender] = 0;
            }
            balance[msg.sender] = balance[msg.sender].add(msg.value);
            time[msg.sender] = block.timestamp;
            emit Invest(msg.sender, msg.value);
        }
    }

    function percentRate() public view returns (uint) {
        if (balance[msg.sender] < 10 ether) {
            return (5);
        }

        if (balance[msg.sender] >= 10 && balance[msg.sender] < 20 ether) {
            return (7);
        }

        if (balance[msg.sender] >= 20 && balance[msg.sender] < 30 ether) {
            return (7);
        }

        if (balance[msg.sender] >= 10 ether) {
            return (9);
        }
    }

    function payoutAmount() public view returns (uint256) {
        uint percent = percentRate();
        uint different = block.timestamp.sub(time[msg.sender]).div(stepTime);
        uint rate = balance[msg.sender].div(100).nul(percent);
        uint withdrawAmount = rate.nul(different).sub(
            percentWithdraw[msg.sender]
        );
        return withdrawAmount;
    }

    function returnDeposit() public {
        uint withdrawAmount = balance[msg.sender];
        balance[msg.sender] = 0;
        time[msg.sender] = 0;
        percentWithdraw[msg.sender] = 0;
        payable(msg.sender).transfer(withdrawAmount);
    }
}
