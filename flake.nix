{
  description = "tinymist flake: 自动拉取并编译主分支";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tinymist-src.url = "github:Myriad-Dreamin/tinymist/main";
    tinymist-src.flake = false; # 不需要将源代码作为一个flake输入
    unisonSync.url = "path:tools/unison-sync";
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
            cargoHash = "sha256-Lvkmy5q1oZKaKWb6963AaNYURxLpViRqJ3dTgFxsGhs=";
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
      }
    );
}
