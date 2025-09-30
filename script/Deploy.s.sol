// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/BigTransferTrap.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        BigTransferTrap trap = new BigTransferTrap();
        console.log("BigTransferTrap deployed at:", address(trap));

        vm.stopBroadcast();
    }
}
