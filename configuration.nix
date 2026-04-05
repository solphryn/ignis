{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Rollback btrfs root to blank on every boot
  boot.initrd.systemd = {
    enable = true;
    services.rollback = {
      description = "Rollback btrfs root subvolume to a pristine state";
      wantedBy = [ "initrd.target" ];
      after = [ "systemd-cryptsetup@cryptroot.service" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /mnt
        mount -o subvol=/ /dev/mapper/cryptroot /mnt

        btrfs subvolume list -o /mnt/root |
          cut -f9 -d' ' |
          while read subvolume; do
            echo "deleting /$subvolume subvolume..."
            btrfs subvolume delete "/mnt/$subvolume"
          done &&
          echo "deleting /root subvolume..." &&
          btrfs subvolume delete /mnt/root

        echo "restoring blank /root subvolume..."
        btrfs subvolume snapshot /mnt/root-blank /mnt/root

        umount /mnt
      '';
    };
  };

  time.timeZone = "Europe/Stockholm";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  zramSwap.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  
  system.stateVersion = "25.11";
}
