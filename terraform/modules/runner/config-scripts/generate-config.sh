#!/bin/bash
# generated terraform template file
# place here all variables
cat <<'EOF' >/home/ubuntu/config.cfg
%{ if GH_RUNNER_VERSION != "" ~}
export GH_RUNNER_VERSION='${GH_RUNNER_VERSION}'
%{ endif ~}
%{ if GH_RUNNER_HASH != "" ~}
export GH_RUNNER_HASH='${GH_RUNNER_HASH}'
%{ endif ~}
%{ if GH_RUNNERGROUP != "" ~}
export GH_RUNNERGROUP='${GH_RUNNERGROUP}'
%{ endif ~}
%{ if GH_URL != "" ~}
export GH_URL='${GH_URL}'
%{ endif ~}
%{ if GH_TOKEN != "" ~}
export GH_TOKEN='${GH_TOKEN}'
%{ endif ~}
EOF
