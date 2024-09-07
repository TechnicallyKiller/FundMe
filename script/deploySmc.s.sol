// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import "forge-std/Scripts.sol";
import {SimpleStorage} from "../src/Counter.sol";
contract deploySmartContract is Script{
    function run() external  returns (SimpleStorage) {
        vm.startBroadcast();
        SimpleStorage simpleStor = new SimpleStorage();
        vm.stopBroadcast();
        return simpleStor;
        
    }
}