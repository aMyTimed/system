# Just a simple apply script to apply the flake to the system.
# Instead of requiring manual setup, this script allows you to just clone the repo and apply it with one command.

# If /etc/nixos exists, move it to /etc/nixos.backup. If that exists, keep trying of increasing the number.
# We don't use /etc/nixos and instead have the config locally in this repo.
if [ -d "/etc/nixos" ]; then
    echo "Moving /etc/nixos to /etc/nixos.backup, so this flake can be used.";
    if [ -d "/etc/nixos.backup" ]; then
        i=1;
        while [ -d "/etc/nixos.backup.$i" ]; do
            i=$((i+1));
        done
        sudo mv /etc/nixos "/etc/nixos.backup.$i";
    else
        sudo mv /etc/nixos /etc/nixos.backup;
    fi
fi

# Each time, we generate a fresh hardware configuration.
# This is useful because it ensures the right config is used on each system without requiring manual intervention.
# It can also guarantee the hardware config will never be missing.
nixos-generate-config --show-hardware-config | sudo dd status=none of=./hardware-configuration.nix;
echo "Generated hardware configuration";

echo "Rebuilding NixOS...";
sudo nixos-rebuild switch --flake .#somewhere;

echo;
echo "Finished! Check above logs to make sure there were no errors.";