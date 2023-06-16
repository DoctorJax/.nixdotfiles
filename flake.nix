{
  description = "Home Manager configuration of jackson";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    nixgl = {
      url = "github:guibou/nixGL";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    {
      homeConfigurations."jackson" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
          overlays =
            let
              OpenASARdiscord = self: super: {
                discord-canary = super.discord-canary.override { withOpenASAR = true; };
              };
            in
          [
            inputs.nixgl.overlay
            inputs.hyprland-contrib.overlays.default
            OpenASARdiscord
          ];
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          inputs.hyprland.homeManagerModules.default
          ./home.nix
        ];

        extraSpecialArgs = { inherit inputs; };
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
