// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Dice {
    uint256 private nonce = 0;

    function getRandomNumber() internal returns (uint256) {
        nonce++;
        return uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao,
                    msg.sender,
                    nonce
                )
            )
        ) % 10 + 2;
    }

    function Winner() public returns (string memory, uint256, uint256) {
        uint256 player1 = getRandomNumber();
        uint256 player2 = getRandomNumber();
        
        if (player1 > player2) return ("Player 1 Wins", player1, player2);
        else if (player1 < player2) return ("Player 2 Wins", player1, player2);
        else return ("Draw", player1, player2);
    }
}
