// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IBigTransferResponse.sol";

contract BigTransferResponse is IBigTransferResponse {
    // ...
}

interface IBigTransferResponse {
    function recordBigTRansfer(address from, address to, uint256 amount) external;
    function getAlert(address addr) external view returns (
        address from,
        address to,
        uint256 amount,
        uint256 timestamp,
        bool isActive
    );
}

contract BigTransferResponse is IBigTransferResponse {
    struct BigTransferAlert {
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
        bool isActive;
    }
    
    mapping(address => Alert) private alerts;
    address[] public alertAddresses;
    
    event BigTransferRecorded(address indexed from, address indexed to, uint256 amount, uint256 timestamp);
    
    function recordBigTransfer(address from, address to, uint256 amount) external override {
        alerts[to] = Alert({
            to: to,
            amount: amount,
            timestamp: block.timestamp,
            isActive: true
        });

        emit BigTransferRecorded(from, to, amount, block.timestamp);
    }
    
    function getAlert(address addr) external view override returns (
        address from,
        address to,
        uint256 amount,
        uint256 timestamp,
        bool isActive
    ) {
        Alert storage a = alerts[addr];
        return (a.from, a.to, a.amount, a.timestamp, a.isActive);
    }
}
