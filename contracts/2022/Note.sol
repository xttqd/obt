// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;
contract Note {
  string public name;
  uint number;
  string public adress;

  function set(string memory newName,uint newNumber,string memory newAdress) public {
    name=newName;
    number=newNumber;
    adress=newAdress;
  
}
  function get() public view returns (string memory, uint,string memory){
  return (name,number,adress);
}
}