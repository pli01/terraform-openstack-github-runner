#!/bin/bash
set -e -o pipefail

echo "# RUNNING: $(dirname $0)/$(basename $0)"

cat <<'EOF' > /home/ubuntu/install-runner.sh
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

GH_RUNNER_VERSION="${GH_RUNNER_VERSION:-2.298.2}"
GH_RUNNER_HASH="${GH_RUNNER_HASH:-0bfd792196ce0ec6f1c65d2a9ad00215b2926ef2c416b8d97615265194477117}"
# Create a folder
[ -d actions-runner ] || mkdir actions-runner
(
cd actions-runner
# Download the latest runner package
curl -o actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz
# Optional: Validate the hash
echo "${GH_RUNNER_HASH} actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz" | sha256sum -c
# Extract the installer
tar xzf ./actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz
)
EOF
echo "# run /home/ubuntu/install-runner.sh"
chmod +x /home/ubuntu/install-runner.sh
su - ubuntu -c "bash -c /home/ubuntu/install-runner.sh"
echo "# end /home/ubuntu/install-runner.sh"
