# Lightning Network

Pre-configured, dockerized lightning network small cluster, using lnd and btcd
in dev mode.

## Building

Use [docker build](https://docs.docker.com/engine/reference/commandline/build/) 
to build the container images.

```bash
docker build -f Dockerfile.lnd -t tutorial/lnd .
```

```bash
docker build -f Dockerfile.btcd -t tutorial/btcd .
```

## Usage

Use [docker-compose](https://docs.docker.com/compose/) to run the containers.

```bash
docker-compose up -d
```

and to stop them

```bash
docker-compose down
```

### Configuration

Use the command line to configure and manage the network nodes:


Create a new wallet

```bash
docker exec -ti alice /bin/sh -c "lncli --network=simnet create"
```

and generate a new receiving address

```bash
docker exec alice /bin/sh -c "lncli --network=simnet newaddress np2wkh"
```

update .env file with the newly generated address and then restart btcd

```bash
docker-compose up -d
```

generate enough blocks for SegWit activation

```bash
docker exec btcd /bin/sh -c "btcctl --simnet --rpcuser=kek --rpcpass=kek --rpccert=/rpc/rpc.cert --rpcserver=localhost generate 400"
docker exec btcd /bin/sh -c "btcctl --simnet --rpcuser=kek --rpcpass=kek --rpccert=/rpc/rpc.cert --rpcserver=localhost getblockchaininfo | grep segwit -A 1"
docker exec alice /bin/sh -c "lncli --network=simnet walletbalance"
```

### Connecting Bob and Alice nodes

```bash
docker exec -ti bob /bin/sh -c "lncli --network=simnet create"
```

Get "Bob" identity pubkey

```bash
docker exec -ti bob /bin/sh -c "lncli --network=simnet getinfo | grep identity_pubkey"
```

and IP address

```bash
docker inspect bob | grep IPAddress
```

connect Alice to Bob node

```bash
docker exec alice /bin/sh -c "lncli --network=simnet connect <node key>@<node ip>"
```

verify the connection on both sides

```bash
docker exec alice /bin/sh -c "lncli --network=simnet listpeers"
docker exec bob /bin/sh -c "lncli --network=simnet listpeers"
```

create the channel

```bash
docker exec alice /bin/sh -c "lncli --network=simnet openchannel --node_key=<node key> --local_amt=1000000"
docker exec btcd /bin/sh -c "btcctl --simnet --rpcuser=kek --rpcpass=kek --rpccert=/rpc/rpc.cert --rpcserver=localhost generate 3"
docker exec alice /bin/sh -c "lncli --network=simnet listchannels"
```

### Send payments

Generate the invoice

```bash
docker exec bob /bin/sh -c "lncli --network=simnet addinvoice --amt=10000"
```

From the output, copy the payment request and then send the payment

```bash
docker exec -ti alice /bin/sh -c "lncli --network=simnet sendpayment --pay_req=<payment request>"
```

Check balances

```bash
docker exec alice /bin/sh -c "lncli --network=simnet channelbalance"
docker exec bob /bin/sh -c "lncli --network=simnet channelbalance"
```

Follow [Working with LND and Docker](https://dev.lightning.community/guides/docker/) for more.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)