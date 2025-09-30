// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IBigTransferResponse {
    function recordAlert(
        address from,
        address to,
        uint256 amount,
        uint256 blockNumber
    ) external;
}
