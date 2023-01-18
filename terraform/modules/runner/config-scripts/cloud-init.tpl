#cloud-config
#
# terraform template format
#
merge_how: dict(recurse_array)+list(append)
%{ if ssh_authorized_keys != "" ~}
ssh_authorized_keys: ${ssh_authorized_keys}
%{ endif ~}
#
final_message: "END The instance is up, after $UPTIME seconds"
