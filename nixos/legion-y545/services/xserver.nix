{ ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    monitorSection = "DisplaySize 345 194";
    desktopManager.plasma5 = {
      enable = true;
      useQtScaling = true;
    };
    displayManager = {
      sddm = {
        enable = true;
      };
      defaultSession = "plasma";
    };

    videoDrivers = [ "nvidia" ];
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
} 
