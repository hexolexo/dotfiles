{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; }; # Allows unstable packages to be installed with unstable.<Package-Name>
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hexolexo"; # Define your hostname.
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ 8000 ]; # For rocket server
  };
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  services = {
  	printing.enable = false; # Intentionally Disabled
	power-profiles-daemon.enable = true; # Power Optimisations
  	xserver = {
  		# GDM and Gnome # Might want to consider removing this for minimalism
  		enable = true;
  		displayManager.gdm.enable = true;
  		#desktopManager.gnome.enable = true;
  	};
  };

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  # Enable sound with pipewire. # TODO: find unused parts
  security.rtkit.enable = true;
  sound.enable = true;
  hardware = {
  	pulseaudio.enable = true;
  	bluetooth.enable = true;
  	pulseaudio.support32Bit = true;
  	pulseaudio.package = pkgs.pulseaudioFull;
  };
  
  users.defaultUserShell = pkgs.bash;
  environment.variables.EDITOR = "micro";
  users.users.hexolexo = {
    isNormalUser = true;
    description = "hexolexo";
    extraGroups = [ "networkmanager" "wheel" "audio" ]; # Suggested Groups: "dialout" "libvirtd"
    packages = with pkgs; [
      obsidian
      alacritty
      floorp
      # blender-hip # Currently not doing 3d modeling
	  # cura
	  duckdb # To replace: libreoffice-fresh: calc
    ];
  };


  environment.variables.PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
  # https://discourse.nixos.org/t/rust-pkg-config-fails-on-openssl-for-cargo-generate/39759/3

  programs.neovim = {
    enable = true;
    defaultEditor = false;
    vimAlias = true;
    viAlias = true;
  };

  nixpkgs.config.allowUnfree = true; # TODO: do something like the unstable packages to reduce unfree software on the system
  environment.systemPackages = with pkgs; [
	# Code
    micro
    git

	## nvim
	fzf
    universal-ctags
    silver-searcher
    python3
    lua
    ripgrep
    fd
    unzip
    # TODO: Need to remove bloat

    ## Languages
    rustup
    rust-analyzer
    pkg-config
    nodejs_22
    # clang # Not sure if I need this
	openssl # for some rust packages

    ### Shells
   	bash
   	starship
   	bat
   	tree

	# System
    btop
    fw-ectool
    pass
    gnupg
    pinentry-curses
	pamixer
	virt-manager
	wl-clipboard-rs
	dunst
	libnotify
	xdg-desktop-portal-hyprland
	# expect # Not sure if I need this
	openvpn # because the school proxy blocks ssh://github.com
	nvd

    ## Hyprland
    eww
    swaybg
    wofi
   	# playerctl # useful for music
    brightnessctl
    swaylock-effects
    grimblast

    # Fonts
    fira-code
  ];
    
  programs.gnupg.agent = {
     enable = true;
     pinentryPackage = pkgs.pinentry-curses;
  };
  
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];


  system.stateVersion = "24.05"; # Don't change this dumbass
}
