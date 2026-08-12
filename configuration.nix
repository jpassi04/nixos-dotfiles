{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.power-profiles-daemon.enable = true;
  
  time.timeZone = "America/Chicago";

  services.getty.autologinUser = "julian";

  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };

  services.ollama = {
     enable = true;
     package = pkgs.ollama-cuda;
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.graphics.enable = true;
 
  hardware.nvidia = {
     modesetting.enable = true;
     open = false;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  users.users.julian = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
  };

    hardware.cpu.amd.updateMicrocode = true;

    nixpkgs.config.allowUnfree = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

  
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ]; 

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        # Add common simulator libraries here if errors persist
        libGL
        libx11
        libxcursor
        libxrandr
        libxinerama
        libxi
        glib
    ];
 

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    ghostty
    kitty
    unimatrix
    waybar
    git
    hyprpaper
    rofi
    swaynotificationcenter
    yazi
    wlogout
    slurp
    fastfetch
    btop
    vscodium-fhs
    hypridle
    hyprpicker
    hyprpolkitagent
    hyprshutdown
    udiskie
    wl-clipboard
    rofi-bluetooth
    hyprland
    swayosd
    mako
    grim
    cliphist 
    xdg-desktop-portal-hyprland
    libsForQt5.qtwayland
    qt6.qtwayland
    hyprpolkitagent
    networkmanagerapplet
    brightnessctl
    pamixer
    pavucontrol
    gnome-themes-extra
    tmux
    zsh
    bat
    eza
    ripgrep
    lazygit
    lazydocker
    neovim
    bluez
    bluez-alsa
    vesktop
    spotify
    spicetify-cli
    unzip
    bolt
    thermald
    stress-ng
    exiftool
    networkmanager_dmenu
    binwalk
    checksec
    ltrace
    strace
    patchelf
    upx
    pwninit
    hyprlock
    matugen
    awww
    pulseaudio
    blueman
    peaclock
    playerctl
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";

}

