// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;


contract SimpleStorage {
    uint256 public favoriteNum;
    uint256[] public listFavNum;

    struct Person {
        uint256 favoriteNum;
        string name;
    }

    Person[] public listOfPeeps;
    mapping(string => uint256) public nameToFav;

    // Store a new favorite number
    function store(uint256 _favoriteNum) public {
        favoriteNum = _favoriteNum;
    }

   
}