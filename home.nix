{ config, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  home.username = "julian";
  home.homeDirectory = "/home/julian";
  home.stateVersion = "26.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec start-hyprland
      fi
    '';
  };

  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink /home/julian/nixos-dotfiles/config/hypr;
  home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink /home/julian/nixos-dotfiles/config/rofi;
  home.file.".config/wlogout".source = config.lib.file.mkOutOfStoreSymlink /home/julian/nixos-dotfiles/config/wlogout;
  home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink /home/julian/nixos-dotfiles/config/waybar;
  home.file.".config/yazi".source = config.lib.file.mkOutOfStoreSymlink /home/julian/nixos-dotfiles/config/yazi;
  home.file.".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink /home/julian/nixos-dotfiles/config/ghostty;
  home.file.".config/swaync".source = config.lib.file.mkOutOfStoreSymlink /home/julian/nixos-dotfiles/config/swaync;

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.fluent;
    colorScheme = "comfy";
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
    ];
    enabledCustomApps = with spicePkgs.customApps; [ ];
    spotifyPackage = pkgs.spotify;
  };

  xdg.desktopEntries.optcg-sim = {
      name = "OPTCG Sim";
      exec = "/home/julian/Documents/Builds_Linux/OPTCGSim.x86_64";
      terminal = false;
      categories = [ "Game" ];
  };
}
