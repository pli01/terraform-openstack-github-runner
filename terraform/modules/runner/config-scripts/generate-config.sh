#!/bin/bash
# generated terraform template file
# place here all variables
cat <<'EOF' >/home/ubuntu/config.cfg
%{ if http_proxy  != "" ~}
export http_proxy='${http_proxy}'
export https_proxy='${http_proxy}'
%{ endif ~}
%{ if no_proxy  != "" ~}
export no_proxy='${no_proxy}'
%{ endif ~}
%{ if URL_DEPLOY_RUNNER  != "" ~}
export URL_DEPLOY_RUNNER='${URL_DEPLOY_RUNNER}'
export URL_DEPLOY_RUNNER='${URL_DEPLOY_RUNNER}'
%{ endif ~}
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
%{ if GH_LABEL != "" ~}
export GH_LABEL='${GH_LABEL}'
%{ endif ~}
EOF
