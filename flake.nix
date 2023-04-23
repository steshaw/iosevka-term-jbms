{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        plan = builtins.readFile(./private-build-plans.toml);
      in {
        defaultPackage = pkgs.iosevka.override {
          set = "term-jbml";
          privateBuildPlan = plan;
        };
      }
    );
}
