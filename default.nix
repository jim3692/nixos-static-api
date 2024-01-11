{ lib, pkgs, ... }:

let
  api-root = pkgs.callPackage ./lib/json-files.nix {
    api-paths = {
      hello = {
        status = 200;
        response = "Hello!";
      };
    };
  };
in {
  services.nginx = {
    enable = true;

    virtualHosts."api.local" = {
      onlySSL = false;
      locations."/".root = "${api-root}";
    };
  };
}
