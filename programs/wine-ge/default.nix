{ stdenv, lib, fetchurl }:

stdenv.mkDerivation rec {
  pname = "wine-ge-custom";
  version = "GE-Proton8-26";

  src = fetchurl {
    url = "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/${version}/wine-lutris-${version}-x86_64.tar.xz";
    sha256 = "nO8pKFCkcLGiY3silZBRqzZ4TczbSWbBlgd5Ch46lvE=";
  };

  buildCommand = ''
    mkdir -p $out
    tar -C $out --strip=1 -x -f $src
  '';
}
