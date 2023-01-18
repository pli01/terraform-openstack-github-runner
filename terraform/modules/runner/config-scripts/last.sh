#!/bin/bash
set -e -o pipefail
echo "# RUNNING: $(dirname $0)/$(basename $0)"

script="last.sh"
cat <<'EOF_SCRIPT' > /home/ubuntu/${script}
#!/bin/bash
reboot
EOF_SCRIPT
echo "# run /home/ubuntu/${script}"
chmod +x /home/ubuntu/${script}
/bin/bash -c /home/ubuntu/${script}
echo "# end /home/ubuntu/${script}"
