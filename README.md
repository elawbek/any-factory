# A factory to clone any contract on the network

## test

put `ETH_RPC_URL` to `.env` file
```shell
forge test -vvvv
```


## deploy and script

put `<NETWORK>_RPC_URL`, `ETH_API_KEY` and `PRIVATE_KEY` to `.env` file
```shell
forge script script/AnyFactory.s.sol -vvvv --rpc-url <network> --broadcast --verify
```

holesky address: [0x2Bee2E47E8efAF683249fb2d607836b3be6aA5Bb](https://holesky.etherscan.io/address/0x2Bee2E47E8efAF683249fb2d607836b3be6aA5Bb#code)

sepolia address: [0xD2Fb4063883b8c3CEb45C8D827Ba5D6C312f9a1E](https://sepolia.etherscan.io/address/0xD2Fb4063883b8c3CEb45C8D827Ba5D6C312f9a1E#code)


### CloneContract script:
```shell
forge script script/CloneContract.s.sol -vvvv --rpc-url <network> --sig "run(address,address)" <anyFactoryAddress> <contractAddress> --broadcast
```
