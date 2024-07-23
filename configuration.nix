# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.

    ];

# BOOTLOADER
  boot = {
     # Kernel
     kernelPackages = pkgs.linuxPackages_zen;
     # This is for OBS Virtual Cam Support
     kernelModules = [ "v4l2loopback" "transparent_hugepage=madvise" "i915"];
     extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
     # Needed For Some Steam Games
     kernel.sysctl = {
       "vm.max_map_count" = 2147483642;
     };
     # Bootloader.
     loader.systemd-boot.enable = true;
     loader.efi.canTouchEfiVariables = true;
     # Make /tmp a tmpfs
     tmp = {
       useTmpfs = false;
       tmpfsSize = "30%";
     };
     # Appimage Support
     binfmt.registrations.appimage = {
       wrapInterpreterInShell = false;
       interpreter = "${pkgs.appimage-run}/bin/appimage-run";
       recognitionType = "magic";
       offset = 0;
       mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
       magicOrExtension = ''\x7fELF....AI\x02'';
     };
     plymouth.enable = true;
   };

   # Extra Module Options
    drivers.amdgpu.enable = true;
    drivers.nvidia.enable = false;
    drivers.nvidia-prime = {
      enable = false;
      intelBusID = "";
      nvidiaBusID = "";
    };
    drivers.intel.enable = false;
    vm.guest-services.enable = false;
    local.hardware-clock.enable = false;


# HOSTNAME
networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
networking.networkmanager.enable = true;

# Set your time zone.
time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

# PROGRAM MODULE
  programs = {
    firefox.enable = false;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        buf = {
          symbol = " ";
        };
        c = {
          symbol = " ";
        };
        directory = {
          read_only = " 󰌾";
        };
        docker_context = {
          symbol = " ";
        };
        fossil_branch = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
        };
        golang = {
          symbol = " ";
        };
        hg_branch = {
          symbol = " ";
        };
        hostname = {
          ssh_symbol = " ";
        };
        lua = {
          symbol = " ";
        };
        memory_usage = {
          symbol = "󰍛 ";
        };
        meson = {
          symbol = "󰔷 ";
        };
        nim = {
          symbol = "󰆥 ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        ocaml = {
          symbol = " ";
        };
        package = {
          symbol = "󰏗 ";
        };
        python = {
          symbol = " ";
        };
        rust = {
          symbol = " ";
        };
        swift = {
          symbol = " ";
        };
        zig = {
          symbol = " ";
        };
      };
    };
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.navatej = {
    isNormalUser = true;
    description = "Navatej Ratnan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
   vim
   wget
   killall
   eza
   git
   cmatrix
   lolcat
   fastfetch
   htop
   brave
   libvirt
   lxqt.lxqt-policykit
   lm_sensors
   unzip
   unrar
   libnotify
   v4l-utils
   ydotool
   duf
   ncdu
   wl-clipboard
   pciutils
   ffmpeg
   socat
   cowsay
   ripgrep
   lshw
   bat
   pkg-config
   meson
   hyprpicker
   ninja
   brightnessctl
   virt-viewer
   swappy
   appimage-run
   networkmanagerapplet
   yad
   inxi
   playerctl
   nh
   nixfmt-rfc-style
   discord
   libvirt
   swww
   grim
   slurp
   gnome.file-roller
   swaynotificationcenter
   imv
   mpv
   gimp
   pavucontrol
   tree
   spotify
   neovide
   greetd.tuigreet
# USER PACKAGES
   whatsapp-for-linux
   whatsapp-emoji-font
   nchat
   deadbeef
   libsForQt5.elisa
   yt-dlp
   auto-cpufreq
   thermald
   cpupower-gui
   firefox
   python313
   pipx
   python312Packages.pip
   zed-editor
   ruby
   zig
   go
   wireshark
   ani-cli
   dra-cla
   blender
   kdePackages.kdenlive
   gnome-frog
   arduino
   erlang
   flutter # Programming Language flutter
   fantomas # Programming Language F#
  ];

  fonts = {
     packages = with pkgs; [
       noto-fonts-emoji
       noto-fonts-cjk
       font-awesome
       symbola
       material-icons
     ];
   };

   # HYPRLAND
   xdg.portal = {
     enable = true;
     wlr.enable = true;
     extraPortals = [
       pkgs.xdg-desktop-portal-gtk
       pkgs.xdg-desktop-portal
     ];
     configPackages = [
       pkgs.xdg-desktop-portal-gtk
       pkgs.xdg-desktop-portal-hyprland
       pkgs.xdg-desktop-portal
     ];
   };

# SERVICES
services = {
  xserver = {
    enable = false;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        # Wayland Desktop Manager is installed only for user ryan via home-manager!
        user = username;
        # .wayland-session is a script generated by home-manager, which links to the current wayland compositor(sway/hyprland or others).
        # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config here.
        # command = "$HOME/.wayland-session"; # start a wayland session directly without a login manager
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
      };
    };
  };
  smartd = {
    enable = false;
    autodetect = true;
  };
  libinput.enable = true;
  fstrim.enable = true;
  auto-cpufreq.enable = true;
  thermald.enable = true;
  cpupower-gui.enable = true;
  gvfs.enable = true;
  openssh.enable = true;
  flatpak.enable = false;
  printing = {
    enable = true;
    drivers = [
      # pkgs.hplipWithPlugin
    ];
  };

  # Extra Logitech Support
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

# FLATPAK
systemd.services.flatpak-repo = {
  path = [ pkgs.flatpak ];
  script = ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  '';
};

# Optimization settings and garbage collection automation
nix = {
  settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
};

# Virtualization / Containers
 virtualisation.libvirtd.enable = true;
 virtualisation.podman = {
   enable = true;
   dockerCompat = true;
   defaultNetwork.settings.dns_enabled = true;
 };

 # OpenGL
 hardware.opengl = {
   enable = true;
 };

 # HARDWARE CONFIGURATION

 {
   imports =
     [ (modulesPath + "/installer/scan/not-detected.nix")
     ];

   boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
   boot.initrd.kernelModules = [ ];
   boot.kernelModules = [ "kvm-intel" "i915" "transparent_hugepage=madvise" ];
   boot.extraModulePackages = [ ];

   fileSystems."/" =
     { device = "/dev/disk/by-uuid/9cff9a7e-0bc1-4e4c-a4f4-0e78b2b393f1";
       fsType = "ext4";
     };

   fileSystems."/boot" =
     { device = "/dev/disk/by-uuid/86FE-6D88";
       fsType = "vfat";
       options = [ "fmask=0022" "dmask=0022" ];
     };

   fileSystems."/data" =
     { device = "/dev/disk/by-uuid/2191a3dd-76da-4c41-ab4d-21c01edf7a5e";
       fsType = "ext4";
     };

   swapDevices = [ ];

   # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
   # (the default) this is the recommended approach. When using systemd-networkd it's
   # still possible to use this option, but it's recommended to use it in conjunction
   # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
   networking.useDHCP = lib.mkDefault true;
   # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

   nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
   hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
 }


system.stateVersion = "24.05"; # Did you read the comment?

}
