with import <nixpkgs> {};
mkShell {
  buildInputs = [
    pkgconfig
    openssl
  ];

  shellHook = ''
    export RUSTFLAGS="-C link-arg=-fuse-ld=lld"
  '';
}
