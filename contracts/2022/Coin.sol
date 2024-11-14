// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Coin {
  address owner;
  string name;
  string symbol;
  uint256 totalCoins;

  function coin() public {
  owner = msg.sender;
  name = "Coin";
  symbol = "MYC";
  totalCoins = 1000;
  balance[owner] = totalCoins;
  }

  mapping (address => uint256) public balance;

  function totalSupply() view public returns (uint256) {
    return totalCoins;
  }

  function balanceOf(address _owner) view public returns (uint256) {
    return balance[_owner];
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    if (balance[msg.sender] > _value) {
      address _from = msg.sender;
      owner = _to;
      emit Transfer(_from, _to, _value);
      balance[_from] = balance[_from] - _value;
      balance[_to] = balance[_to] + _value;
      return true;
    }
    return false;
  }

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
