# Validator-Deployment #

### Requirements ###

* [docker](https://docs.docker.com/engine/install/)
* [docker-compose](https://docs.docker.com/compose/install/)

### Fullnode setup through docker-compose ###

1) clone the repo: https://github.com/Oneledger/validator-deployment.git

2) Go to directory where you want to run fullnode either testnet/mainnet

```
cd testnet or cd mainnet

mkdir oldata
```

3) run docker-compose

```
sudo docker-compose -f docker-compose.yml up -d
```

4) In "docker-compose.yml" we mount docker volume to "oldata" directory, To check your data

```
cd oldata
```

5) Validate node status

```
sudo docker-compose exec olfullnode sh -c "olclient validatorset"
```

- Go to [Mainnet explorer](https://mainnet-explorer.oneledger.network/), check out the current block height (For Mainnet)

- Go to [Testnet explorer](https://frankenstein-explorer.oneledger.network/), check out the current block height (For Testnet)

The node will take some time to catch up to Mainnet current height, wait until two heights are same or with only 1~2 block difference

### Validator setup ###

1) Have a Mainnet fullnode running (Currently only mainnet supports validator setup, Please follow above steps to setup mainnet fullnode through docker-compose)

2) Create an account in the secure wallet

```
sudo docker-compose exec olfullnode sh -c "olclient account add --name your_preferred_name_for_memorisation"
```
(Note: It will prompt for password please enter)

3) Run this command to get your node secure wallet stake address

```
sudo docker-compose exec olfullnode sh -c "olclient list"
```

4) Send at least 0.5 Million OLT to this account

- You can use Chrome OneWallet extension to do this if the account you are sending from is in OneWallet

- Or you can use this below command, if the account you are sending from is in another node's secure wallet

```
sudo docker-compose exec olfullnode sh -c "olclient send --party YOUR_ADDRESS_WITHOUT_0lt_PREFIX --counterparty ADDRESS_YOU_WANT_TO_SEND_TOKEN_TO_WITHOUT_0lt_PREFIX --amount 500000 --fee 0.00000001 --currency OLT"
```

5) To become validator you need to stake atleast 0.5 Million OLT

```
sudo docker-compose exec olfullnode sh -c "olclient delegation stake --amount 500000 --address YOUR_STAKINGACCOUNT_WITHOUT_0lt_PREFIX"
```

6) Now you become validator, check the status

```
sudo docker-compose exec olfullnode sh -c "olclient delegation status --address YOUR_STAKINGACCOUNT_WITHOUT_0lt_PREFIX"
```

7) To unstake your OLT (Note: If you unstake total 0.5 Million or less you will no longer be a validator)

```
sudo docker-compose exec olfullnode sh -c "olclient delegation unstake --amount 500000 --address YOUR_STAKINGACCOUNT_WITHOUT_0lt_PREFIX"
```

8) After unstake check your status

```
sudo docker-compose exec olfullnode sh -c "olclient delegation status --address YOUR_STAKINGACCOUNT_WITHOUT_0lt_PREFIX"
```

- When we unstake, there is a period of time referred to as “maturity time”. One can only withdraw the unstaked amount after this maturity time, since the unstake transaction. This maturity time is 80000 blocks, roughly two weeks.

### Rewards ###

1) To Check reward information for a specific validator

```
sudo docker-compose exec olfullnode sh -c 'olclient call query.GetTotalRewardsForValidator {\"validator\":\"REPLACE_YOUR_ADDRESS_HERE_WITHOUT_0lt_PREFIX\"}'
```

2) Once you see no-zero "matureBalance" in above reward information, you are able to withdraw rewards

```
sudo docker-compose exec olfullnode sh -c 'olclient rewards withdraw --amount XXX --address REPLACE_YOUR_STAKEADDRESS_HERE_WITHOUT_0lt_PREFIX'
```
Please enter your password

3) After you withdraw rewards check the increased balance in validator stake address

```
sudo docker-compose exec olfullnode sh -c 'olclient balance --address REPLACE_YOUR_STAKEADDRESS_HERE_WITHOUT_0lt_PREFIX'
```
