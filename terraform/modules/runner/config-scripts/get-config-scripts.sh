#!/bin/bash
set -x -e -o pipefail
echo "# RUNNING: $(dirname $0)/$(basename $0)"

# generate script
script="get-config-scripts.sh"
cat <<'EOF_SCRIPT' > /home/ubuntu/${script}
#!/bin/bash
set -x -e -o pipefail

function clean() {
    ret=$?
    if [ "$ret" -gt 0 ] ;then
        echo "FAILURE $0: $ret"
    else
        echo "SUCCESS $0: $ret"
    fi
    exit $ret
}

trap clean EXIT QUIT KILL

[ -f /home/ubuntu/config.cfg ] && source /home/ubuntu/config.cfg
cd /home/ubuntu

echo "# Download from $RUNNER_URL_DEPLOYER_SCRIPT"
curl -OL "$RUNNER_URL_DEPLOYER_SCRIPT"
chmod +x "$(basename $RUNNER_URL_DEPLOYER_SCRIPT)"

echo "# Run $RUNNER_URL_DEPLOYER_SCRIPT"
bash "$(basename $RUNNER_URL_DEPLOYER_SCRIPT)"

EOF_SCRIPT

# run script
echo "# run /home/ubuntu/${script}"
chmod +x /home/ubuntu/${script}
/home/ubuntu/${script}
echo "# end /home/ubuntu/${script}"
