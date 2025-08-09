{ pkgs, lib, ... }:
{
  # Help devenv locate the project root when used via flakes
  devenv.root = ".";

  # Tooling and native deps
  packages = with pkgs; [
    nodejs_20
    pnpm
    git
    openssl
    pkg-config
    vips
    cairo
    pango
    libpng
    jpeg
    giflib
    libwebp
  ];
}

