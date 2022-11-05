#!/bin/bash
set -e -o pipefail
echo "# RUNNING: $(dirname $0)/$(basename $0)"

cat <<'EOF' > /home/ubuntu/configure-runner.sh
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

export GH_URL="${GH_URL:?GH_URL not defined}"
export GH_TOKEN="${GH_TOKEN:?GH_TOKEN not defined}"
export GH_RUNNERGROUP="${GH_RUNNERGROUP:-Default}"
export GH_RUNNERNAME="${GH_RUNNERNAME:-$(hostname)}"

[ -d actions-runner ] || exit 1
(
cd actions-runner
# Install dependencies
sudo ./bin/installdependencies.sh

# Create the runner and start the configuration experience
./config.sh  --unattended --replace \
        --name "${GH_RUNNERNAME}" \
        --runnergroup "${GH_RUNNERGROUP}" \
       	--url ${GH_URL} --token ${GH_TOKEN}
# Last step, run it!
sudo ./svc.sh install
sudo ./svc.sh start
)

EOF
echo "# run /home/ubuntu/configure-runner.sh"
chmod +x /home/ubuntu/configure-runner.sh
su - ubuntu -c "bash -c /home/ubuntu/configure-runner.sh"
echo "# end /home/ubuntu/configure-runner.sh"
