// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "node_modules/@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library fileConv {
    function getLatestPrice(AggregatorV3Interface pricefeed) public view returns (uint256) {
        (, int256 price,,,) = pricefeed.latestRoundData();
        return uint256(price) * 1e10;
    }
    // Function to convert a value based on the price

    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed) internal view returns (uint256) {
        uint256 ethPrice = getLatestPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}
