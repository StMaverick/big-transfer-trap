// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IBigTransferResponse.sol";

contract BigTransferResponse is IBigTransferResponse {
    event AlertRecorded(
        address indexed from,
        address indexed to,
        uint256 amount,
        uint256 blockNumber
    );

    function recordAlert(
        address from,
        address to,
        uint256 amount,
        uint256 blockNumber
    ) external override {
        emit AlertRecorded(from, to, amount, blockNumber);
    }
}
