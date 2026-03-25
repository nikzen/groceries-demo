{
  description = "nikzen / groceries-demo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    engineering-standards.url = "github:famedly/engineering-standards";

  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.engineering-standards.flakeModules.default ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, ... }:
        
        {
          famedly.standards = {
            checks.enable = true;
            infrastructure = {
              editorconfig = true;
              dependabot = true;
              dependabotDart = true;
            };
            rules = {
              enable = true;
              extraScopes = [ "dart" ];
            };
            linting = {
              enable = true;
              dart = true;
            };
            hooks = {
              enable = true;
              dart = true;
            };
            ci = {
              enable = true;
              armRunners = true;
            };
            dart = {
              enable = true;
              flutter = false;
            };
          };

          devShells.default = pkgs.mkShell {
            packages = [ pkgs.dart ];
          };
        };
    };
}