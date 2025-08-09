{
  description = "Postiz dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, systems, ... }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nodejs_20
              pnpm
              podman
              podman-compose
              jq
              openssh
              # native build deps often needed by node packages (sharp, canvas, etc.)
              pkg-config
              vips
              cairo
              pango
              libpng
              libjpeg
              giflib
              libwebp
              openssl
              python3
            ];
            shellHook = ''
              corepack enable >/dev/null 2>&1 || true
            '';
          };
        }
      );
    };
}

