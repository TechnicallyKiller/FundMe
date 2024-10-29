// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/fundme.sol";
import {deploySmartContract} from "../script/deploySmc.s.sol";

contract FundmeTest is Test {
    FundMe fundme;
    address USER = makeAddr("alex");
    uint256 SEND_VALUE = 5 ether;

    function setUp() external {
        deploySmartContract deploy1 = new deploySmartContract();
        fundme = deploy1.run();
        vm.deal(USER, 10 ether);
    }

    function test_MinUSd() public view {
        assertEq(fundme.minUsd(), 5e18);
    }

    function test_msgOwner() public view {
        console.log(msg.sender);
        assertEq(fundme.getOwner(), msg.sender);
    }

    function testFundUpdatesFundDataStructure() public {
        vm.prank(USER);
        fundme.fund{value: 8 ether}();
        uint256 amountFunded = fundme.getAddressToAmountFunded(USER);

        assertEq(amountFunded, 8 ether);
    }

    function testFundUpdatesFundDataStructure2() public {
        vm.prank(USER);
        fundme.fund{value: 8 ether}();
        address getFunder2 = fundme.getFunder(0);
        assertEq(USER, getFunder2);
    }

    function testFundFailsWIthoutEnoughETH() public {
        vm.expectRevert(); // <- The next line after this one should revert! If not test fails.
        fundme.fund(); // <- We send 0 value
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();

        vm.expectRevert();
        vm.prank(USER);
        fundme.withdraw();
    }

    function testWithdrawfromSingleOwner() public {
        uint256 startingContractBalance = address(fundme).balance;
        uint256 startingOwnertBalance = fundme.getOwner().balance;

        vm.startPrank(fundme.getOwner());
        fundme.withdraw();
        vm.stopPrank();

        uint256 finalContractBalance = address(fundme).balance;
        uint256 finalOwnertBalance = fundme.getOwner().balance;
        assertEq(startingContractBalance + startingOwnertBalance, finalOwnertBalance);
        assertEq(finalContractBalance, 0);
    }

    function testPrintStorageData() public {
        for (uint256 i = 0; i < 3; i++) {
            bytes32 value = vm.load(address(fundme), bytes32(i));
            console.log("Vaule at location", i, ":");
            console.logBytes32(value);
        }
        console.log("PriceFeed address:", address(fundme.getPriceFeed()));
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
