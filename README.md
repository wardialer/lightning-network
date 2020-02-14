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

Use the command line to configure and manage the network nodes [...]
(to be completed)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)