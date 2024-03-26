# for the funny, we allow people to choose to apply any host configuration
# this is useful if youre changing hostnames or something

# no arg = just default it
if [ -z "$1" ]; then
    sudo nixos-rebuild switch --flake path:.;

# arg = apply that host if it exists
else
    # Make sure ./hosts/$1 exists
    if [ ! -d "./hosts/$1" ]; then
        echo "Host $1 does not exist!";
        exit 1;
    fi
    sudo nixos-rebuild switch --flake path:.#$1;
    
fi