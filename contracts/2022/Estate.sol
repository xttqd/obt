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

  mapping (uint => Estate) public estates;
  uint e_length = 0;

  //структура описания подарка
  struct Present{
    uint estate_id;
    address adr_from;
    address adr_to;
    bool status;
  }

  mapping (uint => Present) public presents;
  uint p_length = 0;

  //структура описание продажи
  struct Sale {
    uint estate_id;
    address owner;
    uint price;
    address payable[] customers;
    uint[] prices;
    bool status;
  }
    
    mapping (uint => Sale) public sales;
    uint  s_length = 0;

  //моификатор - проверки на статусы подарка
  modifier isOwner(uint estate_id) {
    require(msg.sender == estates[estate_id].owner);
    require(estates[estate_id].present_status == false);
    require(estates[estate_id].sale_status == false);
    _;        
  }

  address admin = msg.sender;

  //создаем объект недвижимости
  function create_estate(address owner, string memory info, uint square) public {
    require(msg.sender == admin, "You are not admin");
    estates[e_length] = Estate(owner, info, square, false, false);
    e_length = e_length + 1;
  }

  //реализация дарения
  function create_present(uint id, address adr_to) public isOwner(id) {
    presents[p_length] = Present(id, msg.sender, adr_to, true);
    p_length = p_length + 1;
    estates[id].present_status = true;
  }

  //отмена дарения
  function stop_present(uint p_id) public {
    require(presents[p_id].status == true, "Already not presented");
    require(presents[p_id].adr_from == msg.sender, "Not your present");
    uint e_id = presents[p_id].estate_id;
    presents[p_id].status = false;
    estates[e_id].present_status = false;
  }

  //принятие пользователем подарка
  function get_present(uint p_id) public {
    require(presents[p_id].status == true, "Already not presented");
    require(presents[p_id].adr_to == msg.sender, "Not for you");
    uint e_id = presents[p_id].estate_id;
    presents[p_id].status = false;
    estates[e_id].present_status = false;
    estates[e_id].owner = msg.sender;        
  }

  //реализация продажи
  function create_sale(uint e_id, uint price) public isOwner(e_id) {
    address payable[] memory customers;
    uint[] memory prices;
    sales[s_length] = Sale(e_id, msg.sender, price, customers, prices, true);
    estates[e_id].sale_status = true;
  }

  //покупка
  function buy(uint s_id) public payable {
    require(msg.sender != sales[s_id].owner);
    require(msg.value >= sales[s_id].price);
    require(sales[s_id].status == true);
    sales[s_id].customers.push(payable(msg.sender));
    sales[s_id].prices.push(msg.value);
  }

  //продажа
  function confirm_sale(uint s_id, uint u_id) public payable {
    require(sales[s_id].status == true);
    require(msg.sender == sales[s_id].owner);
    uint e_id = sales[s_id].estate_id;
    for (uint i = 0; i < sales[s_id].customers.length; i++) {
      address payable user = sales[s_id].customers[i];
      if (i != u_id) {
        user.transfer(sales[s_id].prices[i]);
        }
      else {
        payable(msg.sender).transfer(sales[s_id].prices[i]);
        estates[e_id].owner = user;
      }
    }
    sales[s_id].status = false;
    estates[e_id].sale_status = false;
  }

  //чек
  function get_sale(uint s_id) public view returns(uint, address, uint, address payable[] memory, uint[] memory, bool) {
    return(sales[s_id].estate_id, sales[s_id].owner, sales[s_id].price, sales[s_id].customers, sales[s_id].prices, sales[s_id].status);
  }

}
