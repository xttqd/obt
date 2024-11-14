// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Shop {

  //Пользователь
  struct Owner {
    address owner;
    string name;
    string info;
    uint balance;
  }

  mapping (uint => Owner) public owner;
  uint o_lenght = 0;
  
  //Добавить пользователя
  function SetUser (string memory name, string memory info) public {
    for(uint i = 0; i < o_lenght; i++)
    {
      require(keccak256(abi.encodePacked(owner[i].name)) != keccak256(abi.encodePacked(name)), "Choose another name");
    }
    owner[o_lenght] = Owner(msg.sender, name, info, 0);
    o_lenght = o_lenght + 1;
  }
  
  //Пополнить баланс
  function PlusBalance (uint value) public {
    for(uint i = 0; i < o_lenght; i++){
      if (owner[i].owner == msg.sender) {
        owner[i].balance = owner[i].balance + value;
      } 
    }
  }
  //Запросы на покупку
  function Buy (string memory name, uint value) public {
    for(uint i = 0; i < o_lenght; i++){
      if (owner[i].owner == UserAddress(name)) {
        owner[i].balance = owner[i].balance + value;
      } 
      if (owner[i].owner == msg.sender) {
        owner[i].balance = owner[i].balance - value;
      }  
    }
  }
//Продукт
  struct Product {
    address owner;
    string name;
    string info;
    uint mincount;
    uint price;
    //bool status;
  }

  mapping (uint => Product) public product;
  uint p_lenght = 0;
  
//Поставка продукта
  struct ProductDelivery {
    address owner;
    string provider;
    string name;
    uint price;
    uint count;
    bool status;
  }

  mapping (uint => ProductDelivery) public productdel;
  uint pd_lenght = 0;

  //Продажа
  struct SaleProduct {
    address owner;
    string nameshop;
    string name;
    uint count;
    uint prise;
    bool status;
    bool statusback;
  }

  mapping (uint => SaleProduct) public salep;
  uint sp_lenght = 0;

 //Количество товара у магазина
  struct MinCountShops {
    
  }

  //Проверка пользователя
  function UserVerification (address user, string memory info) public view returns (bool) {
    for(uint i = 0; i < o_lenght; i++)
    {
      if (owner[i].owner == user) {
       if (keccak256(abi.encodePacked(owner[i].info)) == keccak256(abi.encodePacked(info))) {
         return true;
       } else return false;
      }
    }
  } 

  //Возврат адреса
  function UserAddress (string memory name) public view returns (address) {
    for (uint i = 0; i < o_lenght; i++) {
      if (keccak256(abi.encodePacked(owner[i].name)) == keccak256(abi.encodePacked(name))) {
        return owner[i].owner;
      }
    }
  }
  
  //Возврат количества товара поставщика на складе
  function CountProduct (string memory name) public view returns (uint) {
    uint pc = 0;
    for(uint i = 0; i < p_lenght; i++){
      if (keccak256(abi.encodePacked(product[i].name)) == keccak256(abi.encodePacked(name))) {
        pc = pc + product[i].mincount;
      }  
    }
    return pc;
  }

//Поставщик
  //Добавить продукт
  function CreateProduct(string memory info, string memory name, uint count, uint price) public {
    require(UserVerification(msg.sender, "Provider") == true, "You not Provider");
      product[p_lenght] = Product(msg.sender, name, info, count, price);
      p_lenght = p_lenght + 1;
       
  }

  //Подтвердить поставку
  function UpStatusSupplyProduct(uint id_pd) public {
    require(UserVerification(msg.sender, "Provider") == true, "You not Provider");
    require(CountProduct(productdel[id_pd].name) > productdel[id_pd].count, "Not enough product");
    for(uint i = 0; i < p_lenght; i++){
      if (keccak256(abi.encodePacked(product[i].name)) == keccak256(abi.encodePacked(productdel[id_pd].name))){
        product[i].mincount = product[i].mincount - productdel[id_pd].count;
      }  
    }
    productdel[id_pd].status = true;
  }
//КонецПоставщика

 //Магазин
  //Запрос на поставку
  function CreateSupply(string memory name, string memory nameprov, uint count) public {
    uint price = 0;
    require(UserVerification(msg.sender, "Shops") == true, "You not Shops");
    for (uint i = 0; i < p_lenght; i++)
    {
      if (keccak256(abi.encodePacked(product[i].name)) == keccak256(abi.encodePacked(name)))
      {
        price = product[i].price * count; 
      }  
    }
    productdel[pd_lenght] = ProductDelivery(msg.sender, nameprov, name, price, count, false);
    pd_lenght = pd_lenght + 1; 
    require(msg.sender.balance < price, "Insufficient funds");
    Buy(nameprov, price);  
  }
 //КонецМагазин

 //Продавец
  //Подтверждение покупки
  function UpStatusSaleProduct(uint id_s) public {
    require(UserVerification(msg.sender, "Saleman") == true, "You not Saleman");
      salep[id_s].status = true;   
  }
  
  //Подверждение возврата
  function UpStatusBackSaleProduct(uint id_s) public {
   require(UserVerification(msg.sender, "Saleman") == true, "You not Saleman");
   require(salep[id_s].statusback != true, "No return issued");
    salep[id_s].status = true;
  }
 //КонецПродавец

 //Покупатель
  //Запрос на покупку
  function CreateSaleProduct(string memory name, string memory nameshop, uint count) public {
    uint price = 0;
    require(UserVerification(msg.sender, "Buyer") == true, "You not Buyer");
    for (uint i = 0; i < p_lenght; i++)
    {
      if (keccak256(abi.encodePacked(product[i].name)) == keccak256(abi.encodePacked(name)))
      {
        price = product[i].price * count; 
      }  
    }
    salep[sp_lenght] = SaleProduct(msg.sender, nameshop, name, count, price, false, false); 
    require(msg.sender.balance < price, "Insufficient funds");
    Buy(nameshop, price);  
  }

  //Запрос на возврат
  function StopSale(uint id_s) public {
    require(UserVerification(msg.sender, "Buyer") == true, "You not Buyer");
    salep[id_s].statusback = true;  
  }
 //КонецПокупатель
}


