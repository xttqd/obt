// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Insurance {
    address payable public hospital;
    address payable public insurer;

    struct Record {
        address Addr;
        uint256 ID;
        string Name;
        string date;
        uint256 price;
        bool isValue;
        uint256 signatureCount;
        mapping(address => uint256) signature;
    }

    modifier signOnly() {
        require(msg.sender == hospital || msg.sender == insurer);
        _;
    }

    constructor() {
        hospital = payable(0x92e32563159EF37017F892F9Dc2ba601566BBD42);
        insurer = payable(0x36Ca97601cED35c9E70ad4d5eeCAD90de6f35a89);
    }

    mapping(uint256 => Record) public all_record;
    uint256[] public recordsArr;

    event recordCreated(
        uint256 ID,
        string testName,
        string date,
        uint256 price
    );
    event recordSigned(uint256 ID, string testName, string date, uint256 price);

    function newRecord(
        uint256 _ID,
        string memory _Name,
        string memory _date,
        uint256 price
    ) public {
        Record storage newrecord = all_record[_ID];
        require(!all_record[_ID].isValue);
        newrecord.Addr = msg.sender;
        newrecord.ID = _ID;
        newrecord.Name = _Name;
        newrecord.date = _date;
        newrecord.price = price;
        newrecord.isValue = true;
        newrecord.signatureCount = 0;
        recordsArr.push(_ID);
        emit recordCreated(newrecord.ID, _Name, _date, price);
    }

    function signRecord(uint256 _ID) public payable signOnly {
        Record storage records = all_record[_ID];
        require(records.signature[msg.sender] != 1);
        records.signature[msg.sender] = 1;
        records.signatureCount++;
        emit recordSigned(
            records.ID,
            records.Name,
            records.date,
            records.price
        );
        if (records.signatureCount == 2) {
            hospital.transfer(address(this).balance);
        }
    }
}
