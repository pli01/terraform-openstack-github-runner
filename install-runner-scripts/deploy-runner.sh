#!/bin/bash
set -e -o pipefail

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

export RUNNER_URL_DEPLOYER_SCRIPT="${RUNNER_URL_DEPLOYER_SCRIPT:?RUNNER_URL_DEPLOYER_SCRIPT not defined}"
URL_PATH=$(dirname ${RUNNER_URL_DEPLOYER_SCRIPT})

# list of ordered install scripts
CONFIG_SCRIPTS_FILE="package.sh apt.sh install-runner.sh configure-runner.sh last.sh"

for script in ${CONFIG_SCRIPTS_FILE}; do
	echo "# Download/Install $URL_PATH/${script}"
	bash -c "$(curl -fsSL $URL_PATH/$script)"
done
