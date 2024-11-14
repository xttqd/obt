// SPDX-License-Identifier: Unlicense

pragma solidity >=0.7.0 <0.9.0;

contract Mail {
 
  address MainAdmin = 0x92e32563159EF37017F892F9Dc2ba601566BBD42;
  enum AdminRole { MainAdminSistem, AdminSistem, NUUl }
  enum EmployeeRole { Work, NUUL}
  enum TypePackage { Letter, ParcelPost, Package }
  enum Class { One, Two, Three}
  enum WayPackage { SenderPostOffice,  MainPostOffice, SortingCenter, RecipientPostOffice}

//Структуры
  //Структура администраторов
  struct OwnerAdmin {
    address ownera;
    string name;
    string homeaddress;
    uint balance;
    AdminRole role;
  }
  
  mapping (uint => OwnerAdmin) public owheradmin;
  uint oa_linght = 0;
  OwnerAdmin public ow;
  
  //Структура сотрудников
  struct Employee {
    address ownere;
    string name;
    string homeaddress;
    uint balance;
    string idbranch;
    EmployeeRole role;
  }

  mapping (uint => Employee) public employee;
  uint e_linght = 0;
  Employee private e;

  //Структура Пользователи
  struct User {
    address owneru;
    string name;
    string homeaddress;
    uint balance;
  }

  mapping (uint => User) public user;
  uint u_linght = 0;

  //Структура индексы 
  struct MailPlace {
    string mailplace;
    string inx;
    WayPackage way;
  }

  mapping (uint => MailPlace) public mailplaceA;
  uint mp_linght = 0;

  //Запись данных о почтовом отделении 
  function SendMailPlace() private {
    mailplaceA[0] = MailPlace("SenderPostOffice", "101000", WayPackage.SenderPostOffice);
    mailplaceA[1] = MailPlace("MainPostOffice", "102000", WayPackage.MainPostOffice);
    mailplaceA[2] = MailPlace("SortingCenter", "103000", WayPackage.SortingCenter);
    mailplaceA[3] = MailPlace("RecipientPostOffice", "104000", WayPackage.RecipientPostOffice);
    mp_linght = mp_linght + 3;
  }
  //

  //Структура посылка основа
  struct Package {
    string tracknumber;
    address sender;
    address recipient;
    TypePackage typepackage;
    string addressrecipient;
    string addresssender;
    bool statusreceiving;
    WayPackage statusways;
  }

  mapping (uint => Package) public package;
  uint p_linght = 0;

  //Структура посылка основа
  struct PackageCoin {
    string tracknumber;
    Class class;
    uint deliveryperiod;
    uint costofdelivery;
    uint weight;
    uint declaredvalue;
    uint totalcost;
  }

  mapping (uint => PackageCoin) public packagecoin;
  uint pc_linght = 0;

  struct PackageWay {
    string num;
    WayPackage wayp;
  }

  mapping (uint => PackageWay) public packageway; 
  uint pw_linght = 0;

  struct TrackNumberGenerationS {
    string a;
    string b;
    string indx;
    string c;
  }

  mapping (uint => TrackNumberGenerationS) public tracknumbergenerationS;
  TrackNumberGenerationS public tngs;

 //Генерация трек-номера
  function TrackNumberGeneration (uint ID, string memory mailplace) private returns(string memory str) {
    tracknumbergenerationS[0].a = "MR";
    tracknumbergenerationS[0].b = uint2str(block.timestamp);
    tracknumbergenerationS[0].c = uint2str(ID);
    for(uint q = 0; q < mp_linght; q++) {
      if (keccak256(abi.encodePacked((mailplaceA[q].mailplace))) == keccak256(abi.encodePacked((mailplace)))) {
        tracknumbergenerationS[0].indx = mailplaceA[q].inx;
      }
    }
    str = A(tracknumbergenerationS[0].a, tracknumbergenerationS[0].b, tracknumbergenerationS[0].c, 
    tracknumbergenerationS[0].indx);   
    return str;
  }

  function A(string memory a, string memory b, string memory c, string memory indx) private pure returns (string memory str) {
        bytes memory bytesa = bytes(a);
        bytes memory bytesb = bytes(b);
        bytes memory bytesindx = bytes(indx);
        bytes memory bytesc = bytes(c);

        string memory _tmpValue = new string(bytesa.length + bytesb.length + bytesc.length + bytesindx.length);
        bytes memory _newValue = bytes(_tmpValue);

        uint j;

        for(uint i=0; i < bytesa.length; i++) {
            _newValue[j++] = bytesa[i];
        }

        for(uint i=0; i<bytesb.length; i++) {
            _newValue[j++] = bytesb[i];
        }

        for(uint i=0; i<bytesc.length; i++) {
            _newValue[j++] = bytesc[i];
        }

        for(uint i=0; i<bytesindx.length; i++) {
            _newValue[j++] = bytesindx[i];
        }
        str = string(_newValue);
        return str;
    }
  
  //Перевод из uint в string
  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
  }
  
  struct AddressPlusS {
    string addr;
    string indx;
  }

  mapping (uint => AddressPlusS) public addressplusS;
 
  //Сложение адреса 
  function AddressPlus(string memory mailplace, string memory addr) private returns (string memory str ) {
    
    for(uint q = 0; q < mp_linght; q++) {
      if (keccak256(abi.encodePacked((mailplaceA[q].mailplace))) == keccak256(abi.encodePacked((mailplace)))) {
        addressplusS[0].indx = mailplaceA[q].inx;
      }
    }
    str = B(addressplusS[0].indx, addr);
    return str;
  }

  function B (string memory a, string memory b) private pure returns (string memory str) {
    bytes memory bytesmailplace = bytes(a);
    bytes memory bytesaddr = bytes(b);

    string memory _tmpValue = new string(bytesmailplace.length + bytesaddr.length);
    bytes memory _newValue = bytes(_tmpValue);

    uint j;

    for(uint i=0; i < bytesmailplace.length; i++) {
      _newValue[j++] = bytesmailplace[i];
    }

    for(uint i=0; i<bytesaddr.length; i++) {
      _newValue[j++] = bytesaddr[i];
    }
    
    return string(_newValue);
  } 
  //Возврат адреса по имени пользователя 
  function UserAddress(string memory name) private view returns (address o) {
    for (uint i = 0; i < u_linght; i++) {
      if (keccak256(abi.encodePacked((user[i].name))) == keccak256(abi.encodePacked((name)))) 
      {
        o = user[i].owneru;
        return o;
      }
    } 
  }

  //Определение срока доставки 
  function DeliveryPeriodReturns(Class class) private pure returns(uint n) {
    if(class == Class.One) {
      n = 5;
      return n;
    } else if(class == Class.Two) {
      n = 10;
      return n;
    } else if (class == Class.Three) {
      n = 15;
      return n;
    }
  }

  //Определение стоимости доставки
  function CostofDeliveryReturns(Class class) private pure returns(uint n) {
    if(class == Class.One) {
      n = 5;
      return n;
    } else if(class == Class.Two) {
      n = 3;
      return n;
    } else if (class == Class.Three) {
      n = 1;
      return n;
    }
  }
//КонецСтруктур

  constructor () public {
    //объявление главного администратора
    owheradmin[0] = OwnerAdmin(MainAdmin, "Main admin", "st. Bold house 5", 0, AdminRole.MainAdminSistem);
    oa_linght = oa_linght + 1;
    SendMailPlace(); 
  }
  
//Функции главного админа 

  //Функция добавления администраторов
    function SetAdmin(address ownera, string memory name, string memory homeaddress, uint balance) public {
      require(msg.sender == MainAdmin, "You not main admin!");
      balance = 0;
      owheradmin[oa_linght] = OwnerAdmin(ownera, name, homeaddress, balance, AdminRole.AdminSistem);
      oa_linght = oa_linght + 1;
    }
  //

  //Функция удаления администраторов
    /*function DeleteAdmin(uint id) public {
      require(msg.sender == MainAdmin, "You not main admin!");
      owheradmin[id].role = AdminRole.NUUl; 
    }
  //

  //Функция изменения своих данных 
    function GetOwnerAdmin() public view returns(address ownera, string memory name, string memory homeaddress, uint balance, AdminRole role) {
      require(msg.sender == MainAdmin, "You not main admin!");
      return(owheradmin[0].ownera, owheradmin[0].name, owheradmin[0].homeaddress, owheradmin[0].balance, owheradmin[0].role);
    }

    function UpMainAdmin(address ownera, string memory name, string memory homeaddress) public {
      require(msg.sender == MainAdmin, "You not main admin!");
      ow = owheradmin[0];
      owheradmin[0] = OwnerAdmin(ownera, name, homeaddress, ow.balance, ow.role);
    } */
  //

  //Отказ от получения посылки 
    function StopMailMailAdmin(string memory tracknumber) public {
      for (uint i = 0; i <= p_linght; i++) {
        if(keccak256(abi.encodePacked((package[i].tracknumber))) == keccak256(abi.encodePacked((tracknumber)))) {
          package[i].statusreceiving = false;
        }
      }
    } 
  //
//КонецФункцийГлавногоАдмина

//Функции админа
  
  //Функция добавления сотрудников
    function SetEmployee(address ownera, string memory name, string memory homeaddress, string memory idbranch, uint balance) public {
      for (uint i = 0; i < oa_linght; i++) {
        if (owheradmin[i].ownera == msg.sender) {
          require(owheradmin[i].role == AdminRole.AdminSistem, "You not main admin!");
        }
      } 
      employee[e_linght] = Employee(ownera, name, homeaddress, balance, idbranch, EmployeeRole.Work);
      e_linght = e_linght + 1;
    }
  //

  //Функция удаления сотрудников
    /*function DeleteEmployee(uint id) public {
      for (uint i = 0; i < oa_linght; i++) {
        if (owheradmin[i].ownera == msg.sender) {
          require(owheradmin[i].role == AdminRole.AdminSistem, "You not main admin!");
        }
      } 
      employee[id].role = EmployeeRole.NUUL; 
    }
  //*/

  //Функция изменения своих данных 
    /*function GetOwnerAdminSistem() public view returns(address owner, string memory name, string memory homeaddress, uint balance, AdminRole role) {
      for (uint i = 0; i < oa_linght; i++) {
        if (owheradmin[i].ownera == msg.sender) {
          require(owheradmin[i].role == AdminRole.AdminSistem, "You not main admin!");
          return(owheradmin[i].ownera, owheradmin[i].name, owheradmin[i].homeaddress, owheradmin[i].balance, owheradmin[i].role);
        } 
      } 
      
    }

    function UpAdminSistem(address ownera, string memory name, string memory homeaddress, AdminRole role) public {
      for (uint i = 0; i < oa_linght; i++) {
        if (owheradmin[i].ownera == msg.sender) {
          require(owheradmin[i].role == AdminRole.AdminSistem, "You not main admin!");
          owheradmin[i] = OwnerAdmin(ownera, name, homeaddress, 0, role);
        }         
      } 
    } */
  //

  //Отказ от получения посылки 
   /*function StopMailAdminSistem(string memory tracknumber) public {
      for (uint i = 0; i <= p_linght; i++) {
        if(keccak256(abi.encodePacked((package[i].tracknumber))) == keccak256(abi.encodePacked((tracknumber)))) {
          package[i].status = false;
        }
      }
    } */
  //
//КонецФункцийАдмина

//Функуии сотрудника
  //Добавление информации от отправление
    function SendMailA(string memory mailplace, 
    string memory sender, string memory recipient, 
    TypePackage typepackage, 
    string memory addressrecipient, 
    string memory addresssender) public {
      for (uint i = 0; i < e_linght; i++) {
        if (employee[i].ownere == msg.sender) {
          require(employee[i].role == EmployeeRole.Work, "You not main admin!");
        }
      } 
      
      //напиши проверку итоговой стоимости
      package[p_linght] = Package(TrackNumberGeneration(p_linght, mailplace), 
      UserAddress(sender), UserAddress(recipient), 
      typepackage, AddressPlus(mailplace, addressrecipient), 
      AddressPlus(mailplace,addresssender), false, WayPackage.SenderPostOffice);  
    }
  //

  //Отслеживание посылки по пути
    function SendWayPackage(string memory tracknumber) public {
      uint i;
      string memory emp;
      for (i = 0; i < e_linght; i++) {
        if (employee[i].ownere == msg.sender) {
          require(employee[i].role == EmployeeRole.Work, "You not main employee!");
          emp = employee[i].idbranch;
        }
      } 

      WayPackage w;
      for (i = 0; i <= mp_linght; i++) {
        if (keccak256(abi.encodePacked((mailplaceA[i].inx))) == keccak256(abi.encodePacked((emp)))) {
          w = mailplaceA[i].way;
        }
      }

      for (i = 0; i <= p_linght; i++) {
        if (keccak256(abi.encodePacked((package[i].tracknumber))) == keccak256(abi.encodePacked((tracknumber)))) {
          package[i].statusways = w;
          packageway[pw_linght] = PackageWay(package[i].tracknumber, package[i].statusways);
          pw_linght = pw_linght + 1;
        }
      }

    }
    //
    function SendMailB(string memory tracknumber, Class class, uint weight, uint declaredvalue) public {
      for (uint i = 0; i < e_linght; i++) {
        if (employee[i].ownere == msg.sender) {
          require(employee[i].role == EmployeeRole.Work, "You not main admin!");
        }
      } 
      uint totalcost = CostofDeliveryReturns(class)*weight + declaredvalue;
      packagecoin[pc_linght] = PackageCoin(tracknumber, class, DeliveryPeriodReturns(class), 
      CostofDeliveryReturns(class), weight, declaredvalue, totalcost);
    }
  //

  //Изменение данных о себе
    /*function GetOwnerEmployee() public view returns(address ownere, string memory name, string memory homeaddress, uint balance, string memory idbranch, EmployeeRole role) {
      for (uint i = 0; i < e_linght; i++) {
        if (employee[i].ownere != msg.sender) {
          require(employee[i].role == EmployeeRole.Work, "You not Employee mail!");
        } else {
          return(employee[i].ownere, employee[i].name, employee[i].homeaddress, employee[i].balance, employee[i].idbranch, employee[i].role);
        }
      } 
      
    }
    
    function UpEmployee(address ownere, string memory name, string memory homeaddress, string memory idbranch, EmployeeRole role) public {
      for (uint i = 0; i < e_linght; i++) {
        if (employee[i].ownere == msg.sender) {
          require(employee[i].role == EmployeeRole.Work, "You not Employee mail!");
          employee[i] = Employee(ownere, name, homeaddress, 0, idbranch, role);
        } 
      } 
    }*/
  // 
//КонецФункцийСотрудника
  
//Функции клиента
  //Регистрация в системе
    function RegSistemKlient(string memory name, string memory addr, uint balance) public {
      user[u_linght] = User(msg.sender, name, addr, balance);
      u_linght = u_linght + 1;
    }
  //

  //Функция история пути посылки
    /*function HistoryWay(string memory tn) public view returns (WayPackage[] memory) {
      WayPackage[] memory all = new WayPackage[];
      for (uint i = 0; i <= pw_linght; i++) {
        if (keccak256(abi.encodePacked((packageway[i].num))) == keccak256(abi.encodePacked((tn)))) {
          all[i] = packageway[i].wayp;
        }
      }
      return all;
    }*/
  //

  //Возврат данных о клиенте
    /*function GetOwnerUser() public view returns(string memory name, string memory addr) {
      for(uint i = 0; i <= u_linght; i++) {
        if (msg.sender == user[i].owneru) {
          return(user[i].name, user[i].homeaddress);
        }
      }
    }
  //

  //Изменение данных о клиенте
    function UpUser(string memory name, string memory addr) public {
      for(uint i = 0; i <= u_linght; i++) {
        if (msg.sender == user[i].owneru) {
          user[i] = User(msg.sender, name, addr, user[i].balance);
        }
      }
    }*/
  //

  //Отказ от получения посылки 
   /* function StopMail(string memory tracknumber) public {
      for (uint i = 0; i <= p_linght; i++) {
        if(keccak256(abi.encodePacked((package[i].tracknumber))) == keccak256(abi.encodePacked((tracknumber)))) {
          package[i].statusreceiving = false;
        }
      }
    } 
  //

  //Принять посылку 
    function TruuMail(string memory tracknumber) public {
      for (uint i = 0; i <= p_linght; i++) {
        if(keccak256(abi.encodePacked((package[i].tracknumber))) == keccak256(abi.encodePacked((tracknumber)))) {
          package[i].statusreceiving = true;
        }
      }
    } */
  //

  //Просмотр истории всех отправлений
    /*function ReturnsHistorPackege(string memory name) public view returns (string memory pack) {
      for (uint i = 0; i <= p_linght; i++) {
        if(package[i].sender == UserAddress(name)) {
          pack = package[i].tracknumber;
          return pack;
        }
      }
    }*/
  //
//
}
