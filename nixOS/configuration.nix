{  pkgs, ... }: 
#let
    #unstable = import <nixos-unstable> { config = config.nixpkgs.config; }; # Allows unstable packages to be installed with unstable.<Package-Name>
#in
{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
            ./hosts.nix # YOU WILL WANT TO REMOVE THIS OR CREATE A HOSTS FILE
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Security Things
    systemd.coredump.enable = false;
    security.sudo.extraRules= [
    {
        users = [ "hexolexo" ];
        commands = [
        { 
            command = "/run/current-system/sw/bin/ectool --interface=lpc fanduty 100" ;
            options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
        {
            command = "/run/current-system/sw/bin/ectool --interface=lpc fanduty 40" ;
            options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
        {
            command = "/run/current-system/sw/bin/ectool --interface=lpc autofanctrl" ;
            options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
        ];
    }
    ];

    networking.hostName = "hexolexo"; # Define your hostname.

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
                excludePackages = [ pkgs.xterm ];
                displayManager.gdm.enable = true;
                desktopManager.gnome.enable = true;
            };
    # Configure keymap in X11
        xserver.xkb = {
            layout = "us";
            variant = "colemak";
        };
        #clamav = {
        #    daemon.enable = true;
        #    updater.enable = true;
        #};
    };

    # Enable sound with pipewire. # TODO: find unused parts
    security.rtkit.enable = true;
    hardware = {
        pulseaudio.enable = false;
        bluetooth.enable = true;
        pulseaudio.support32Bit = true;
        pulseaudio.package = pkgs.pulseaudioFull;
    };

    users.defaultUserShell = pkgs.bash;
    users.users.hexolexo = {
        isNormalUser = true;
        description = "hexolexo";
        extraGroups = [ "networkmanager" "wheel" "audio" "libvirtd" ]; # Suggested Groups: "dialout" "libvirtd" "adbusers"
            packages = with pkgs; [
                floorp
                obsidian
                alacritty 
                # blender-hip # Currently not doing 3d modeling
                # cura
                duckdb
                typioca
                fastfetch
                thefuck
                #taskwarrior
                #tldr
                #navi
            ];
    };

    environment.variables.PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
    # https://discourse.nixos.org/t/rust-pkg-config-fails-on-openssl-for-cargo-generate/39759/3

    virtualisation.libvirtd.enable = true;
    programs = {
        virt-manager = {
            enable = true;
        };
        
        neovim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
            viAlias = true;
        };

        hyprland = {
            enable = true;
        };

        gnupg.agent = {
            enable = true;
            pinentryPackage = pkgs.pinentry-curses;
        };
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    nixpkgs.config.allowUnfree = true; # TODO: do something like the unstable packages to reduce unfree software on the system
        environment.systemPackages = with pkgs; [
            micro
            git
            # python3 # getting rid of this to see what breaks
            
            #Neovim
                fd
                ripgrep
                lua
                fzf
                silver-searcher
                universal-ctags

            rustup # required by neovim/rust
                rust-analyzer
                pkg-config
                clang
                openssl
                # gcc
            nodejs_23 # required by neovim
            
            go # 
                gopls
                wgo

            bash
                starship
                gum
                bat
                tree
                zoxide

            btop
            fw-ectool
            pass
                gnupg
                pinentry-curses
            pamixer
            virt-manager
            #cockpit
                #cockpit-machines # Waiting till this is released on nix
                virt-viewer



            # Hyprland Specific Tools
            eww
            dunst
            libnotify
            xdg-desktop-portal-hyprland
            swaybg
            wofi
            wl-clipboard-rs
            brightnessctl
            swaylock-effects
            grimblast
            nvd

            # Fonts
            fira-code
        ];

    fonts.packages = with pkgs; [(nerdfonts.override { fonts = [ "FiraCode" ]; })];

    system.stateVersion = "24.05"; # Don't change this dumbass
    system.autoUpgrade = {
        enable = true;
    };
}
