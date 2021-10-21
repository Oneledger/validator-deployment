      #!/bin/bash
      if [ -d "$OLDATA/nodedata" ] && [ -d "$OLDATA/consensus" ]; then
        echo "restarting an existing node, skip initialization"
      else
        $GOROOT/bin/fullnodesetup.sh
      fi
      olfullnode node --root $OLDATA