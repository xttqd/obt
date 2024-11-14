// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Donation {
    address payable public owner;
    address[] public donators;

    constructor() public {
        owner = payable(msg.sender);
    }

    function gatherDonation() public payable {
        require(msg.value >= .001 ether);
        donators.push(payable(msg.sender));
    }

    function transferToOwner() external {
        require(msg.sender == owner);
        owner.transfer(address(this).balance);
    }

    function getDonators() public view returns (address[] memory) {
        return donators;
    }
}
