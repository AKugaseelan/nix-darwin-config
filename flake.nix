{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, home-manager}:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
       	  pkgs.ansible
       	  pkgs.bat
       	  pkgs.btop
       	  pkgs.fastfetch
       	  pkgs.fd
       	  pkgs.fzf
       	  pkgs.git
       	  pkgs.lazydocker
       	  pkgs.lazygit
       	  pkgs.mas
       	  pkgs.neovim
          pkgs.nixd
       	  pkgs.nodejs_24
       	  pkgs.openssl
          pkgs.starship
          pkgs.zsh-autosuggestions
          pkgs.zsh-syntax-highlighting
        ];

      fonts.packages = [
	pkgs.nerd-fonts.fira-code
      ];

      homebrew = {
	enable = true;
	casks = [
	  "1Password"
	  "adobe-creative-cloud"
	  "Arc"
	  "Autodesk-Fusion"
	  "Bitwarden"
	  "Discord"
	  "Docker"
	  "Kitty"
	  "Microsoft-auto-update"
	  "Microsoft-Teams"
	  "Notion"
	  "Obsidian"
	  "private-internet-access"
	  "raycast"
	  "Steam"
	  "Tailscale"
	  "Wezterm"
	  "Zed"
	];
	masApps = {
	  "Whatsapp" = 310633997;
	};
	onActivation.cleanup = "zap";
	onActivation.autoUpdate = true;
	onActivation.upgrade = true;
      };

      # Necessary for using determinate nix management
      nix.enable = false;
      # Enable unfree applications
      nixpkgs.config.allowUnfree = true;

      # Set default user
      system.primaryUser = "akugaseelan";

      # Enable Rosetta
      nix.extraOptions = ''
	extra-platforms = x86_64-darwin aarch64-darwin
      '';

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Unlock sudo commands with fingerprint
      security.pam.services.sudo_local.touchIdAuth = true;

      # Home-manager
      users.users.akugaseelan.home = "/Users/akugaseelan";
      home-manager.backupFileExtension = "bak";

      system.defaults = {
	dock = {
	  autohide = true;
	  mru-spaces = false;
	  orientation = "left";
	  tilesize = 16;
	  largesize = 64;
	  magnification = true;
	  mineffect = "genie";
	  minimize-to-application = true;
	  show-recents = false;
	};
	trackpad = {
	  Clicking = true;
	  TrackpadThreeFingerDrag = true;
	};
	finder.AppleShowAllExtensions = true;
	finder.FXPreferredViewStyle = "clmv";
	screencapture.location = "~/Pictures/screenshots";
	screensaver.askForPasswordDelay = 10;
	controlcenter.BatteryShowPercentage = true;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
	nix-homebrew.darwinModules.nix-homebrew
	{
	  nix-homebrew = {
	    enable = true;
	    enableRosetta = true;
	    user = "akugaseelan";
	  };
	}
	home-manager.darwinModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.akugaseelan = import ./home.nix;
	}
      ];
    };
  };
}
