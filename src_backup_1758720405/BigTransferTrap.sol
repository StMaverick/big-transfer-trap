// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IBigTransferResponse.sol";

contract BigTransferTrap {
    address public owner;
    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    struct TransferData {
        address from;
        address to;
        uint256 amount;
        uint256 blockNumber;
    }

    event BigTransferDetected(address indexed from, address indexed to, uint256 amount);

    IBigTransferResponse public responseContract;
    uint256 public constant BIG_TRANSFER_THRESHOLD = 1000 * 10**18;

    constructor() {
        owner = msg.sender; // zero-arg constructor for Drosera
    }

    function setResponseContract(address _responseContract) external onlyOwner {
        responseContract = IBigTransferResponse(_responseContract);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "zero address");
        owner = newOwner;
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

    function shouldRespond(TransferData[] calldata transfers) public pure returns (bool) {
        if (transfers.length == 0) return false;
        for (uint i = 0; i < transfers.length; i++) {
            if (transfers[i].amount >= BIG_TRANSFER_THRESHOLD) {
                return true;
            }
        }
        return false;
    }

    function isShouldRespond(TransferData[] calldata transfers) external pure returns (bool) {
        return shouldRespond(transfers);
    }

    function respond(TransferData[] calldata transfers) external {
        require(transfers.length > 0, "No transfers");

        for (uint i = 0; i < transfers.length; i++) {
            if (transfers[i].amount >= BIG_TRANSFER_THRESHOLD) {
                emit BigTransferDetected(transfers[i].from, transfers[i].to, transfers[i].amount);

                if (address(responseContract) != address(0)) {
                    try responseContract.recordBigTransfer(
                        transfers[i].from,
                        transfers[i].to,
                        transfers[i].amount
                    ) {
                        // ok
                    } catch {
                        // ignore failures
                    }
                }
                break;
            }
        }
    }
}
