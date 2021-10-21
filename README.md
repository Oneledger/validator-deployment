# fullnode #

### Requirements ###

* [docker](https://docs.docker.com/engine/install/)
* [docker-compose](https://docs.docker.com/compose/install/)

### fullnode setup through docker-compose ###

1) clone the repo: https://github.com/Oneledger/fullnode.git

2) Go to directory where you want to run fullnode either testnet/mainnet

```
cd testnet or cd mainnet
```

3) run docker-compose

```
sudo docker-compose -f docker-compose.yml up -d
```

4) In "docker-compose.yml" we mount docker volume to "oldata" directory, To check your data

```
cd oldata
```

5) List out docker container

```
sudo docker ps
```

6) Now connect to docker container, CONTAINER_ID can be found in the above result

```
sudo docker exec -it CONTAINER_ID /bin/bash
```

```
cd /home/node/data
```

7) Validate node status

- Go to [Mainnet explorer](https://mainnet-explorer.oneledger.network/), check out the current block height
- Use `olclient validatorset` command to see the block height showing on this node

The node will take some time to catch up to Mainnet current height, wait until two heights are same or with only 1~2 block difference