// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Grades {
  struct Calc {
    uint amount;
    uint sum;
    uint average;
  }
  mapping (string => Calc) public results;
  function MyGrade(string memory title, uint grade) public{
    require(grade>0 &&grade<6);
    results[title].amount++;
    results[title].sum+=grade;
    results[title].average=uint(results[title].sum/results[title].amount);
  }
  
}
