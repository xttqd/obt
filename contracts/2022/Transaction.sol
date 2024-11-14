// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Transaction {
 address public owner;
 mapping (address => uint) public balances;
 event Sent(address from, address to, uint amout);

 constructor() public {
   owner = msg.sender;
 }
 function coin(address receiver, uint amount) public {
   require(msg.sender == owner, "Error!");
   require(amount < 1e60, "The biggest summ!");
   balances[receiver] += amount;
 }
 function send(address receiver, uint amount) public {
   require(amount <= balances[msg.sender], "Not found amount...");
   balances[msg.sender] -= amount;
   balances[receiver] += amount;
   emit Sent(msg.sender, receiver, amount);
 }
}
