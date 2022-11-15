#cloud-config
#
# terraform template format
#
merge_how: dict(recurse_array)+list(append)
# install default package
packages:
  - curl
  - sudo
  - jq
  - bzip2
  - unzip
  - zip
  - p7zip-full
  - p7zip-rar
  - python-is-python3
  - pypy3
  - tree
  - git
  - python3
  - python3-dev
  - python3-pip
  - python3-venv
#
%{ if ssh_authorized_keys != "" ~}
ssh_authorized_keys: ${ssh_authorized_keys}
%{ endif ~}
#
final_message: "END The instance is up, after $UPTIME seconds"
