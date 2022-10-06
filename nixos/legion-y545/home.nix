{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    thunderbird
    nheko
    ark
    haruna
    python3
    ncdu
    sublime-merge
    libsForQt5.plasma-pa
    libsForQt5.kate
    libsForQt5.konsole
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisbalePocket = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DNSOverHTTPS = {
          Enabled = true;
          ProviderURL = "https://223.5.5.5/dns-query";
        };
        ExtensionSettings = {
          "treestyletab@piro.sakura.ne.jp" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
          };
        };
      };
    };
    profiles = {
      default = {
        userChrome = ''
        #TabsToolbar {
          visibility: collapse !important;
        }

        #sidebar-close {
          visibility: collapse !important;
        }
        '';
      };
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      llvm-vs-code-extensions.vscode-clangd
      ms-python.vscode-pylance
      ms-python.python
    ];
  };

  programs = {
    git = {
      enable = true;
      userEmail = "whiredplanck@outlook.com";
      userName = "WhiredPlanck";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fish = {
      enable = true;
      shellAbbrs = {
        rebuild = "nixos-rebuild --use-remote-sudo -v -L --flake /home/panda/Projects/nixos-flakes";
      };
    };
  };

  services = {
    kdeconnect.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nano";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    # cache
    __GL_SHADER_DISK_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    CARGO_HOME = "${config.xdg.cacheHome}/cargo";
    # state
    HISTFILE = "${config.xdg.stateHome}/bash_history";
    LESSHISTFILE = "${config.xdg.stateHome}/lesshst";
    # other
    PYTHONSTARTUP = (
      pkgs.writeText "start.py" ''
        import readline
        readline.write_history_file = lambda *args: None
      ''
    ).outPath;
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
  };
  
  home.stateVersion = "22.11";
}
