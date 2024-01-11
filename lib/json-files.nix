{ stdenv, lib, api-paths, ... }:

let
  helpers = import ./helpers.nix { lib = lib; };
  apiFiles = helpers.conervetApiPathsToTextFiles { apiPaths = api-paths; };
  apiFilesCpLines = helpers.getCpLinesForApiPathsFiles { apiFiles = apiFiles; };

in stdenv.mkDerivation {
  name = "NixOS-based API";
  dontUnpack = true;

  installPhase = ''
    mkdir -p "$out";
    ${apiFilesCpLines}
  '';
}
