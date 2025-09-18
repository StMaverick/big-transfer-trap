// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/BigTransferResponse.sol";
import "../src/BigTransferTrap.sol";

contract DeployScript is Script {
    function run() external {
        vm.startBroadcast();

        BigTransferResponse response = new BigTransferResponse();
        console.log("BigTransferResponse deployed at:", address(response));

        BigTransferTrap trap = new BigTransferTrap(address(response));
        console.log("BigTransferTrap deployed at:", address(trap));

        vm.stopBroadcast();
    }
}
