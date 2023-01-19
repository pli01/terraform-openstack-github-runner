#!/bin/bash
set -e -o pipefail
echo "# RUNNING: $(dirname $0)/$(basename $0)"

script="package.sh"
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

export PACKAGES="curl \
  wget \
  file \
  sudo \
  jq \
  bzip2 \
  unzip \
  zip \
  p7zip-full \
  p7zip-rar \
  tree \
  git \
  python3 \
  python3-dev \
  python3-pip \
  python3-venv \
  acl \
  zstd \
  parallel"

case "$(lsb_release -s -r)" in
   20.*) PACKAGES="$PACKAGES \
            python-is-python3 \
            libpython3.9 \
            pypy3" ;;
esac

apt-get -qy update 
apt-get -qy install $PACKAGES

EOF_SCRIPT
echo "# run /home/ubuntu/${script}"
chmod +x /home/ubuntu/${script}
/home/ubuntu/${script}
echo "# end /home/ubuntu/${script}"
