{
  description = "Unison sync helper for the courses workspace";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        script = pkgs.writeShellScript "unison-sync" ''
          #!/usr/bin/env bash
          if [ "$#" -ne 2 ]; then
            echo "Usage: unison-sync <sourceDir> <destDir>"
            exit 1
          fi
          exec ${pkgs.unison}/bin/unison \
            $1 $2 \
            -ignore 'Name .git' \
            -ignore 'Name .venv' \
            -ignore 'Name result' \
            -ignore 'Name target' \
            -perms 0
        '';
        unisonSync = let 
            currScript = script;
          in
            pkgs.stdenv.mkDerivation {
            name = "unison-sync";
            src = "${currScript}";
            unpackPhase = "true"; # No need to unpack since it's just a script
            propagatedBuildInputs = [ pkgs.unison ];
            installPhase = ''
              mkdir -p $out
              install -Dm755 ${script} $out/unison-sync
            '';
        };
      in {
        packages = {
          unison-sync = unisonSync;
          default = unisonSync;
        };
        apps = {
          unison-sync = {
            type = "app";
            program = "${unisonSync}/unison-sync";
          };
        };
      }
    );
}
