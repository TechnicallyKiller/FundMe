// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Scripts.sol";
import {FundMe} from "../src/fundme.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract deploySmartContract is Script {
    function run() external returns (FundMe) {
        vm.startBroadcast();
        HelperConfig help1 = new HelperConfig();
        address ethUsdpriceFeed = help1.activeConfig();
        FundMe fundme = new FundMe(ethUsdpriceFeed);
        
        vm.stopBroadcast();
        return fundme;
    }
}
