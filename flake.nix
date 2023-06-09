{
  description = "Home Manager configuration of jackson";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
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
  };

  outputs = { nixpkgs, home-manager, hyprland, nixgl, hyprland-contrib, ... }:
    {
      homeConfigurations."jackson" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
          overlays =
            let
              OpenASARdiscord = self: super: {
                discord-canary = super.discord-canary.override { withOpenASAR = true; };
              };
            in
          [
            nixgl.overlay
            hyprland-contrib.overlays.default
            OpenASARdiscord
          ];
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          hyprland.homeManagerModules.default
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
