# Big Transfer Trap

A smart contract system that detects and records unusually large transfers.

## Contracts
- *IBigTransferResponse.sol* – shared interface
- *BigTransferResponse.sol* – stores alerts when big transfers are detected
- *BigTransferTrap.sol* – checks transfers against a threshold and triggers response

## Deployment
This repo uses [Foundry](https://book.getfoundry.sh/).

1. Install dependencies:
   ```bash
   forge install foundry-rs/forge-std --no-commit

2. Create .env from the example:
   ```bash
   cp .env.example .env
Fill in your RPC URL and private key.

3. Build:
   ```bash
   forge build

4. Deploy:
   ```bash
   source .env
   forge script script/Deploy.s.sol \
   --rpc-url $HOODI_RPC_URL \
   --private-key $PRIVATE_KEY \
   --broadcast -vvvv


 ## Testing

 You can simulate transfers and check alerts with cast commands or unit tests in test/.

1. Example:
    ```bash
       cast call <TRAP_ADDR> "BIG_TRANSFER_THRESHOLD()(uint256)" --rpc-url $HOODI_RPC_URL

2. Push to GitHub:
   ```bash
   git init
   git add .
   git commit -m "Initial commit: BigTransferTrap"
   git branch -M main
   git remote add origin https://github.com/<your-username>/big-transfer-trap.git
   git push -u origin main
