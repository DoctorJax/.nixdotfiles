{ config, lib, pkgs, ... }:

{
  imports = [
    ./hypr
    ./kitty.nix
    ./anyrun.nix
    ./swaync.nix
  ];
}
