// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ITrap.sol";

/// @notice Each sample in data must be: abi.encode(address from, address to, uint256 amount, uint256 blockNumber)
/// @dev Newest sample is data[0]
contract BigTransferTrap is ITrap {
    uint256 public constant BIG_TRANSFER_THRESHOLD = 1000 * 10**18;

    // Stateless: runners/off-chain collectors supply samples; nothing to gather here
    function collect() external view override returns (bytes memory) {
        return bytes("");
    }

    function shouldRespond(bytes[] calldata data)
        external
        pure
        override
        returns (bool, bytes memory)
    {
        if (data.length == 0) return (false, "");

        // Expect 4 static 32-byte words (address padded, address padded, uint256, uint256)
        if (data[0].length != 32 * 4) return (false, "");

        (address from, address to, uint256 amount, uint256 blk) =
            abi.decode(data[0], (address, address, uint256, uint256));

        if (amount >= BIG_TRANSFER_THRESHOLD) {
            // Exact payload for: recordAlert(address,address,uint256,uint256)
            return (true, abi.encode(from, to, amount, blk));
        }

        return (false, "");
    }
}
