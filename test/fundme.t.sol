// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/fundme.sol";
import {deploySmartContract} from "../script/deploySmc.s.sol";

contract FundmeTest is Test {
    FundMe fundme;

    function setUp() external {
        fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function test_MinUSd() view public {
        assertEq(fundme.minUsd(), 5e18);
    }

    function test_msgOwner() view public {
        console.log(fundme.owner());
        console.log(msg.sender);
        assertEq(fundme.owner(), address(this));
    }
    
    //solution for work with address outside of system
    //1-
    //unit
    //-testing a specific part of our code
    //2-integration
    //testing how our code works with other parts of code
    //3-Forked
    //testing our code in simulated real env
    //4-Staging
    //testing our code in real world env
}
