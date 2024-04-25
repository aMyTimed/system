{
  description = "System NixOS Flake";

  # This is the standard format for flake.nix.
  # `inputs` are the dependencies of the flake,
  # and `outputs` function will return all the build results of the flake.
  # Each item in `inputs` will be passed as a parameter to
  # the `outputs` function after being pulled and built.
  inputs = {
    # There are many ways to reference flake inputs.
    # The most widely used is `github:owner/name/reference`,
    # which represents the GitHub repository URL + branch/commit-id/tag.

    # Official NixOS package source, using nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    got = {
      url = "github:asour8/got/main";
    };
    umu = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  # `outputs` are all the build result of the flake.
  #
  # A flake can have many use cases and different types of outputs.
  # 
  # parameters in function `outputs` are defined in `inputs` and
  # can be referenced by their names. However, `self` is an exception,
  # this special parameter points to the `outputs` itself(self-reference)
  # 
  # The `@` syntax here is used to alias the attribute set of the
  # inputs's parameter, making it convenient to use inside the function.
  outputs = { self, nixpkgs, home-manager, got, umu, ... }@inputs: {
    nixosConfigurations = {
      "PORTEGE8" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs;  # pass custom arguments into all sub module.
        modules = [
          ./hosts/PORTEGE8/hardware-configuration.nix
          ./hosts/PORTEGE8/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.someone = import ./hosts/PORTEGE8/home.nix;

            home-manager.extraSpecialArgs = {inherit inputs;};
          }
        ];
      };
      "LENOVO720" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs;  # pass custom arguments into all sub module.
        modules = [
          ./hosts/LENOVO720/hardware-configuration.nix
          ./hosts/LENOVO720/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.someone = import ./hosts/LENOVO720/home.nix;

            home-manager.extraSpecialArgs = {inherit inputs;};
          }
        ];
      };
      "IMAGE" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs;  # pass custom arguments into all sub module.
        modules = [
          ./hosts/IMAGE/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.someone = import ./hosts/IMAGE/home.nix;

            home-manager.extraSpecialArgs = {inherit inputs;};
          }
        ];
      };
    };
  };
}