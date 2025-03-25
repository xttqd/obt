// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Dice {
    address public manager;
    address payable[] public point;
    modifier onlyManager() {
        require(manager == msg.sender, "Error!");
        _;
    }
    constructor() {
        manager = msg.sender;
    }
    function CEO() public {
        manager = msg.sender;
    }
    function Enter() public payable {
        require(msg.value > .001 ether, "Min!");
        point.push(payable(msg.sender));
    }
    function getRandomNumber(uint number) public view returns (uint) {
        uint brosok = uint(
            keccak256((abi.encodePacked(block.timestamp, msg.sender, number)))
        ) % 10;
        brosok = brosok + 2;
        return (brosok);
    }
    function Winner()
        public
        payable
        restricted
        returns (string memory, uint, uint)
    {
        uint player1 = getRandomNumber(0);
        uint player2 = getRandomNumber(1);
        if (player1 > player2) {
            point[0].transfer(address(this).balance);
            return ("Winner player 1", player1, player2);
        } else if (player1 < player2) {
            point[1].transfer(address(this).balance);
            return ("Winner player 2", player2, player1);
        } else return ("No winner", player1, player2);
    }
    modifier restricted() {
        require(msg.sender == manager, "error");
        _;
    }
}
