{
  description = "tinymist flake: 自动拉取并编译主分支";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tinymist-src.url = "github:Myriad-Dreamin/tinymist/main";
  };

  outputs = { self, nixpkgs, flake-utils, tinymist-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "tinymist";
          version = "main";
          src = tinymist-src;
          cargoHash = "sha256-iz5NTPqWEVKpQLD7UayiRTeFDerUUAwMQJ4R1NOfC0o=";
          CARGO_PROFILE_RELEASE_LTO = "fat";
          buildType = "release";
          RUSTFLAGS = "-C target-cpu=native";
          doCheck = false;
        };
        devShells.default = pkgs.mkShell rec {
          buildInputs = [ self.packages.${system}.default ];
          TINYMIST_OUT = "${self.packages.${system}.default}/bin";
          shellHook = ''
            export PATH=$TINYMIST_OUT:$PATH
            echo "Tinymist binary is available in PATH."
          '';
        };
      }
    );
}