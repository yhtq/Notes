{
  description = "tinymist flake: 自动拉取并编译主分支";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tinymist-src.url = "github:Myriad-Dreamin/tinymist/main";
    tinymist-src.flake = false; # 不需要将源代码作为一个flake输入
    unisonSync = {
      url = "path:tools/unison-sync";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, tinymist-src, unisonSync }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        syncPackage = unisonSync.packages.${system}.unison-sync;
      in {
        packages = {
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "tinymist";
            version = "main";
            src = tinymist-src;
            cargoHash = "sha256-SaeaylM8yms9WkCJ1iVPGGNr7aVIgt6652J6QRR8XaE=";
            CARGO_PROFILE_RELEASE_LTO = "fat";
            buildType = "release";
            RUSTFLAGS = "-C target-cpu=native";
            doCheck = false;
          };
          unison-sync = syncPackage;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [ self.packages.${system}.default ];
          TINYMIST_OUT = "${self.packages.${system}.default}/bin";
          shellHook = ''
            export PATH=$TINYMIST_OUT:$PATH
            echo "Tinymist binary is available in PATH."
          '';
        };
        apps.default = unisonSync.apps.${system}.unison-sync;
        apps.unison-sync = unisonSync.apps.${system}.unison-sync;
      }
    );
}
