#! /bin/sh

docker build -f Dockerfile.bitcoind -t tutorial/bitcoind . && docker build -f Dockerfile.lnd -t tutorial/lnd .