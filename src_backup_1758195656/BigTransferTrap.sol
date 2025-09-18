// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IBigTransferResponse.sol";

contract BigTransferTrap {
    IBigTransferResponse public responseContract;
    // ...
}

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

contract BigTransferTrap {
    struct TransferData {
        address from;
        address to;
        uint256 amount;
        uint256 blockNumber;
    }
    
    event BigTransferDetected(address indexed from, address indexed to, uint256 amount);

    IBigTransferResponse public responseContract;
    uint256 public constant BIG_TRANSFER_THRESHOLD = 1000 * 10**18;
    
    constructor(address _responseContract) {
        responseContract = IBigTransferRespond(_responseContract);
    }
    
    function collect(
        address from,
        address to,
        uint256 amount
    ) external view returns (TransferData memory) {
        return TransferData({
            from: from,
            to: to,
            amount: amount,
            blockNumber: block.number
        });
    }
    
    function shouldRespond(
        TransferData[] calldata transfers
    ) external pure returns (bool) {
        if (transfers.length == 0) return false;
        for (uint i = 0; i < transfers.length; i++) {
            if (transfers[i].amount >= BIG_TRANSFER_THRESHOLD) {
                return true;
            }
        }
        return false;
    }
    
    // kept for compatibility with your previous name
    function isShouldRespond(
        TransferData[] calldata transfers
    ) external pure returns (bool) {
        return shouldRespond(transfers);
    }
    
    function respond(TransferData[] calldata transfers) external {
        require(transfers.length > 0, "No transfers");
        
        for (uint i = 0; i < transfers.length; i++) {
            if (transfers[i].amount >= BIG_TRANSFER_THRESHOLD) {
                emit BigTransferDetected(transfers[i].from, transfer[i].to, transfers[i].amount);

                responseContract.recordBigTransfer(
                    transfers[i].from,
                    transfers[i].to,
                    transfers[i].amount
                );
                break;
            }
        }
    }
}
