with import <nixpkgs> {};
mkShell {
  buildInputs = [
    pkgconfig
    openssl
  ];
  shellHook = ''
    export RUSTFLAGS="-C target-feature=+crt-static"
  ''
  ;
}
