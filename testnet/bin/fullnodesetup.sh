      #!/bin/bash
      public_ip="$(curl ifconfig.me | awk '{$1=$1};1')" 
      internal_ip="$(hostname -I | awk '{$1=$1};1')"
      config_data_url=https://raw.githubusercontent.com/Oneledger/fullnode/main/testnet/v0.18
      olclient=https://github.com/Oneledger/protocol/releases/download/v0.18.11/olclient
      olfullnode=https://github.com/Oneledger/protocol/releases/download/v0.18.11/olfullnode
      wget $olclient -O $GOROOT/bin/olclient && wget $olfullnode -O $GOROOT/bin/olfullnode && chmod +x $GOROOT/bin/*
      wget $config_data_url/genesis.json -O $OLDATA/genesis.json 
      $GOROOT/bin/olfullnode init --genesis $OLDATA/genesis.json --root $OLDATA
      wget $config_data_url/config.toml -O $OLDATA/config.toml
      sed -i "s/rpc_address.*/rpc_address = \"tcp:\/\/$internal_ip:26604\"/" $OLDATA/config.toml
      sed -i "s/p2p_address.*/p2p_address = \"tcp:\/\/$internal_ip:26605\"/" $OLDATA/config.toml
      sed -i "s/sdk_address.*/sdk_address = \"http:\/\/$internal_ip:26606\"/" $OLDATA/config.toml
      sed -i "s/external_p2p_address.*/external_p2p_address = \"tcp:\/\/$public_ip:26605\"/" $OLDATA/config.toml
      sed -i "s/node_name.*/node_name = \"$internal_ip\"/" $OLDATA/config.toml