{ config, pkgs, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pdp11"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ggrangel = {
    isNormalUser = true;
    description = "ggrangel";
    extraGroups = [ "networkmanager" "wheel" "docker" "k3s" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICjsnosLstbjO8epa4u1zDX26boOYdJZutc6ezSMfZ4o ggrangel@colossus"
    ];
  };

  environment.systemPackages = with pkgs; [
    git   
    home-manager
    neovim  
  ];

  home-manager.users.ggrangel = { pkgs, ... }: {
    home.stateVersion = "25.05";
  };
  

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [22 80 443];
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Adding k3s here instead of home-manager so:
  # it runs as a systemd service, handle permissions correctly and automatically starts on boot.
  services.k3s.enable = true;
  virtualisation.docker.enable = true;

  services.logind = {
    lidSwitchExternalPower = "ignore";
  };

  programs.zsh = {
    enable = true;
  };
  users.users.ggrangel.shell = pkgs.zsh;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;
}
