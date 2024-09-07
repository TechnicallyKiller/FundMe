//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract SimpleStorage{
    uint256 public  favoriteNum;
    uint256[] public ListfavNUM;
    struct Person{
        uint256 favoriteNum;
        string name;
    }
    // Person public myFriend = Person(7, "nigg");
    // Person public My2= Person({favoriteNum: 16, name : "Ded"});
     Person[] public listofPeeps;
     mapping(string => uint256) public nameToFav;

    function store(uint256 _favoriteNum) public {
        favoriteNum=_favoriteNum;
    }
    function retrieve() public view returns (uint256)
    {
        return favoriteNum;
    }
    function addPerson(string memory _name , uint256 _favoriteNumber) public {
    listofPeeps.push(Person(_favoriteNumber,_name));
    nameToFav[_name]=_favoriteNumber;
    }


}
