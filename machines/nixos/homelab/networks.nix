{
  config,
  lib,
  ...
}:
{
  # Network configuration for homelab
  homelab.networks = {
    local = {
      lan = {
        cidr.v4 = "192.168.2.0/24";
        reservations = {
          homelab = { 
            Address = "192.168.2.100";  # The static IP we configured
          };
        };
      };
    };
    external = { };
  };
}
