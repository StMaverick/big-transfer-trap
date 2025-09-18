// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IBigTransferResponse {
    function recordBigTransfer(address from, address to, uint256 amount) external;
    function getAlert(address addr) external view returns (
        address from,
        address to,
        uint256 amount,
        uint256 timestamp,
        bool isActive
    );
}
