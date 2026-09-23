{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        strictDeps = true;

        nativeBuildInputs = with pkgs; [
          jdk25
        ];

        buildInputs = [
        ];

        shellHook = ''
          export JAVA_HOME="${pkgs.buildPackages.jdk25}/lib/openjdk"
        '';
      };
    };
}
