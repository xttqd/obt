// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Estate {
    //структура описания объекта недвижимости
    struct Estate {
        address owner;
        string info;
        uint square;
        bool present_status;
        bool sale_status;
    }

    mapping(uint => Estate) public estates;
    uint e_length = 0;

    //структура описания подарка
    struct Present {
        uint estate_id;
        address adr_from;
        address adr_to;
        bool status;
    }

    mapping(uint => Present) public presents;
    uint p_length = 0;

    //моификатор - проверки на статусы подарка
    modifier isOwner(uint estate_id) {
        require(msg.sender == estates[estate_id].owner);
        require(estates[estate_id].present_status == false);
        require(estates[estate_id].sale_status == false);
        _;
    }

    address admin = msg.sender;

    //создаем объект недвижимости
    function create_estate(
        address owner,
        string memory info,
        uint square
    ) public {
        require(msg.sender == admin, "You are not admin");
        estates[e_length] = Estate(owner, info, square, false, false);
        e_length = e_length + 1;
    }

    //реализация подарка
    function create_present(uint id, address adr_to) public isOwner(id) {
        presents[p_length] = Present(id, msg.sender, adr_to, true);
        p_length = p_length + 1;
        estates[id].present_status = true;
    }

    function stop_present(uint p_id) public {
        require(presents[p_id].status == true, "Already not presented");
        require(presents[p_id].adr_from == msg.sender, "Not your present");
        uint e_id = presents[p_id].estate_id;
        presents[p_id].status = false;
        estates[e_id].present_status = false;
    }
}
