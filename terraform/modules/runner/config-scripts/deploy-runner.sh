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

URL_PATH=$(dirname ${RUNNER_URL_SCRIPTS_PATH})

# list of ordered install scripts
CONFIG_SCRIPTS_FILE="package.sh apt.sh install-runner.sh configure-runner.sh last.sh"

for script in ${CONFIG_SCRIPTS_FILE}; do
	echo "# Get $URL_PATH/${script}"
	curl -OL "$URL_PATH/${script}"
	chmod +x ${script}
	echo "# Run ${script}"
	bash -c ${script}
done
