{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    # editor
    pkgs.helix

    # CLI tools
    pkgs.wget
    pkgs.git
    pkgs.tree

    # browser
    inputs.helium.packages.${pkgs.system}.default

    # chat
    pkgs.discord

    # pw manager 
    pkgs._1password-gui

    # music
    pkgs.spotify

    # pdf
    pkgs.zathura
  ];

  fonts.packages = [
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-cjk-sans
  ];
}
