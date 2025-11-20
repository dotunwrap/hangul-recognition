{
  description = "A website to help beginners learn hangul";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-tree;
          devShells.default = pkgs.mkShell {
            packages = builtins.attrValues {
              inherit (pkgs)
                bun
                husky
                ;
            };
          };
        };
    };
}
