
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18 ;
import {Script} from "forge-std/Scripts.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";
contract HelperConfig is Script{
    uint8 public constant DECIMALS = 8;

    int256 public constant INITIAL_PRICE = 2000e8;
    struct NetworkConfig{
        address priceFeed;
    }
    MockV3Aggregator mockv3;
    NetworkConfig public activeConfig;
    constructor(){
        if(block.chainid==11155111){
            activeConfig=getSepoliaConfig();
        }
        else if (block.chainid==1) {
            activeConfig=getEthConfig();
            
        }
        else{
            activeConfig=getOrCreateAnvilEthConfig();
        }
        
    }
    function getSepoliaConfig() public  returns (NetworkConfig memory) {
        NetworkConfig memory SepoliaConfig= NetworkConfig({
            priceFeed:0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return SepoliaConfig;
        
    }
    function getEthConfig( ) public returns (NetworkConfig memory){
        NetworkConfig memory EthConfig= NetworkConfig({
            priceFeed:0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return EthConfig;
    }
    function getOrCreateAnvilEthConfig() public returns(NetworkConfig memory){
        if (activeConfig.priceFeed != address(0)) {
             return activeConfig;

}
        vm.startBroadcast();
        mockv3=new MockV3Aggregator(DECIMALS,INITIAL_PRICE);
        vm.stopBroadcast();
        

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed:address(mockv3)
        });
        return anvilConfig;

    }
}