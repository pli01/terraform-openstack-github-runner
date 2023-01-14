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
export GH_LABEL="${GH_LABEL:-}"

[ -d actions-runner ] || exit 1
(
cd actions-runner
cat <<EOF_ENV >> .env
http_proxy=${http_proxy}
https_proxy=${https_proxy}
no_proxy=${no_proxy}
EOF_ENV

# Install dependencies
sudo -E ./bin/installdependencies.sh

# Create the runner and start the configuration experience
./config.sh  --unattended --replace \
        --name "${GH_RUNNERNAME}" \
        --runnergroup "${GH_RUNNERGROUP}" \
       --labels "${GH_LABEL}" \
       --url ${GH_URL} --token ${GH_TOKEN}
# Last step, run it!
sudo -E ./svc.sh install
sudo -E ./svc.sh start
sudo -E ./svc.sh status
)

EOF
echo "# run /home/ubuntu/configure-runner.sh"
chmod +x /home/ubuntu/configure-runner.sh
su - ubuntu -c "bash -c /home/ubuntu/configure-runner.sh"
echo "# end /home/ubuntu/configure-runner.sh"
