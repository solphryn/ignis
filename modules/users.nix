{ pkgs, ... }:

{
  users.users.pontus = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$99a7s3/hCMYZ9OMM$jKfUWhBgpl8.MOtNd9Wv2VZJJm4Bl8cZrYo51mXwjgklYXzsbgi65x9Ikb49QjDsKfdA77degSiwRlCietrhm/";
    shell = pkgs.fish;
  };

  users.mutableUsers = false;
}
