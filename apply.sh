# purge all files in /etc/nixos so no lingering files are left
sudo rm -rf /etc/nixos/*
sudo cp -r ./src/* /etc/nixos/
echo "Copied files to /etc/nixos/";

# Each time, we generate a fresh hardware configuration.
# This is useful because it ensures we never break the hardware config or accidentally delete it,
# it will ensure our system is fully deterministic since it makes this file from scratch each time. 
nixos-generate-config --show-hardware-config | sudo dd status=none of=/etc/nixos/hardware-configuration.nix
echo "Generated hardware configuration";

sudo nixos-rebuild switch

echo "All done!";