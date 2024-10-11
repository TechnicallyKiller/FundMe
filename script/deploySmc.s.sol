// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Scripts.sol";
import {FundMe} from "../src/fundme.sol";

contract deploySmartContract is Script {
    function run() external returns (FundMe) {
        vm.startBroadcast();
        FundMe fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        vm.stopBroadcast();
        return fundme;
    }
}
