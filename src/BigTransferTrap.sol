// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BigTransferTrap {
    address public constant RESPONSE_CONTRACT = 0x5eda60b7Fa1ba597aeFF9C43bd1E99E33b531D5F;
    uint256 public constant BIG_TRANSFER_THRESHOLD = 1000 * 10**18;

    function collect() external view returns (bytes memory) {
        return abi.encode(BIG_TRANSFER_THRESHOLD, block.number);
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        if (data.length == 0) {
            return (false, bytes(""));
        }
        
        (uint256 threshold,) = abi.decode(data[0], (uint256, uint256));
        
        if (threshold > 0) {
            return (true, data[0]);
        }
        
        return (false, bytes(""));
    }
}
