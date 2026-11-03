{
  description = "Development tools for the GF180 metastability experiment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            name = "metastability-dev";
            packages = with pkgs; [
              iverilog
              verilator
              yosys
              ngspice
              gnumake
            ];
          };
        }
      );
    };
}
