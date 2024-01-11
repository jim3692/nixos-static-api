{ lib }: {
  conervetApiPathsToTextFiles = { apiPaths }:
    lib.mapAttrs (k: v:
      let jsonText = builtins.toJSON v;
      in rec {
        path = builtins.toFile "${k}.json" "${jsonText}";
        copyCmd = ''cp '${path}' "$out/${k}.json"'';
      }) apiPaths;

  getCpLinesForApiPathsFiles = { apiFiles }:
    lib.foldl' (acc: apiPathName:
      (let copyCmd = apiFiles."${apiPathName}".copyCmd;
      in ''
        ${acc}
        ${copyCmd}
      '')) "" (lib.attrNames apiFiles);
}
