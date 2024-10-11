// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {AggregatorV3Interface} from "node_modules/@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {fileConv} from "./FileConv.sol";

contract FundMe {
    uint256 public myValue = 1;

    using fileConv for uint256;

    address[] public funds;
    mapping(uint256 => address) public AmountToAddress;
    mapping(address funder => uint256 funded) addressToAmount;
    // Function to get the price of Ethereum in USD
    address public owner;
    AggregatorV3Interface private s_pricefeed;

    constructor(address pricefeed) {
        owner = msg.sender;
        s_pricefeed = AggregatorV3Interface(s_pricefeed);
    }

    uint256 public minUsd = 5e18;

    function getPricefeed() public view returns (uint256) {
        return s_pricefeed.version();
    }

    function fund() public payable {
        require(msg.value.getConversionRate(s_pricefeed) >= minUsd, "You need to spend more ETH!");
        funds.push(msg.sender);
        addressToAmount[msg.sender] = addressToAmount[msg.sender] + msg.value;
    }

    function tinyTip() public payable {
        require(msg.value < 1e18, "not small enough");
    }

    function withdraw() public onlyOwner {
        for (uint256 funIndex = 0; funIndex < funds.length; funIndex++) {
            address funder = funds[funIndex];
            addressToAmount[funder] = 0;
        }
        funds = new address[](0);
        // transfer
        // send
        //call
        // msg.sendr= address
        // payable(msg.sender) = payable address
        // payable (msg.sender).transfer(address(this).balance);// will throw error if gas>2300
        // //send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"failed");

        //  //will give boolean response if trans passed or not above 2300gas
        // //call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, " Call Failed");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "sender is not owner");
        _;
    }
    // what happens if someone sends this contract ETH without calling the fund function

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}