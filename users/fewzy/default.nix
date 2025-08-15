{
  pkgs,
  lib,
  ...
}:
{
  nix.settings.trusted-users = [ "fewzy" ];

  users = {
    users = {
      fewzy = {
        shell = pkgs.zsh;
        uid = lib.mkForce 1000;
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "users"
          "video"
          "podman"
          "input"
          "docker"
        ];
        group = "fewzy";
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxPY2z57oMiQHOz/jINpujsKWWZoClgziT4r/BsUMWzuXuqG2A5M+40KqlguvR4QQ7OopP1sUuHw+d+UEVNlUrsrbKtGIQifUJ8KeaRBpTqDiKEnWbHmmWsWSEYJFK5/Vk196oiutdKR+LonH74bv64yXAPf7P2Qh5h67rgTE94WykOWImG1oTTsPXLqmoRMwVu0Ge9uel2Eb4+vlCW8VQdhJMuRdRaM3sEgEviZoNBrc6AlolE+P9iooOXxSEuXIlLeew2I2UXtjF4LXGMaFyD/zKAclTlHx0dAoZkjoFbEMK0QofndjocbL1hs1cOCBEb1bjyiGCiE4X1kxHz/tVYYVwI3eg/9N8Q6PcLXfSsoDZ5QExOcN4JjadXsun6eZWlPKKY3niNHFtFqCz6OgpHGIW7VXxJBHPxjI7PQwJI58GdoeatU9fbsKFFpF+XeKZhJbr/gGTpYDj2DzaKGMh+l7V7K8LvJheNEq+3f3p5YV+gUJy45gu6jIBj8kaYOs= fewzy@Fevzis-MBP.local"
        ];
      };
    };
    groups = {
      fewzy = {
        gid = lib.mkForce 1000;
      };
    };
  };
  programs.zsh.enable = true;
}

