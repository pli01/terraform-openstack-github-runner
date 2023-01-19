# install github runner scripts

This directory contains script to install self hosted github runner
Scripts in this directory are used by cloud-config at boot time
Principe:
- it run on Ubuntu OS instance
- Instance must have internet acces (direct or with corporate proxy)
- On instance: before running scripts, cloud tools must generate in /home/ubuntu/config.cfg a configuration file. This file will be sourced in all scripts. This config file contains following variables needed to install runner.

```
# /home/ubuntu/config.cfg
# corporate proxy
export http_proxy='${http_proxy}'
export https_proxy='${http_proxy}'
export no_proxy='${no_proxy}'
# url path to main deploy-runner.sh script
export RUNNER_URL_DEPLOYER_SCRIPT='${RUNNER_URL_DEPLOYER_SCRIPT}'
# github runner software version to deploy
export GH_RUNNER_VERSION='${GH_RUNNER_VERSION}'
# github runner hash version to deploy
export GH_RUNNER_HASH='${GH_RUNNER_HASH}'
# github runner group (default in free organisation)
export GH_RUNNERGROUP='${GH_RUNNERGROUP}'
# Repo or orga to register this runner
export GH_URL='${GH_URL}'
# Label assigned to this runner
export GH_LABEL='${GH_LABEL}'
# Temporary github token to register
export GH_TOKEN='${GH_TOKEN}'

```

- Download and run deploy-runner.sh: this script will download all other sub script
- Sub scripts are:
   - package.sh: install minimum packages
   - apt.sh: configure apt, disable unattended package,
   - install-runner.sh: download github archive
   - configure-runner.sh: configurer and register github runner
   - last.sh: last steps, reboot

