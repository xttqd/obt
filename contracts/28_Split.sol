// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Split {
    address public owner;
    mapping(address => uint) public balances;
    event Sent(
        address from,
        address receiver1,
        address receiver2,
        address receiver3,
        uint amount
    );

    constructor() {
        owner = msg.sender;
    }
    function Coin(address receiver, uint amount) public {
        require(msg.sender == owner, "Error!");
        require(amount < 1e60, "Very big summ!");
        balances[receiver] += amount;
    }
    function Sent2(
        uint amount,
        address receiver1,
        address receiver2,
        address receiver3
    ) public {
        require(amount <= balances[msg.sender], "Not summ....");
        balances[msg.sender] -= amount;
        balances[receiver1] += amount / 3;
        balances[receiver2] += amount / 3;
        balances[receiver3] += amount / 3;
        emit Sent(msg.sender, receiver1, receiver2, receiver3, amount);
    }
}
