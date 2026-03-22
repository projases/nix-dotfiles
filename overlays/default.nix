{ sf-mono-liga-src }:
{
  sf-mono-liga = final: prev: {
    sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
      pname = "sf-mono-liga-bin";
      version = "dev";
      src = sf-mono-liga-src;
      dontConfigure = true;
      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        cp -R $src/*.otf $out/share/fonts/opentype/
      '';
    };
  };

  lager-boost-fix = final: prev: {
    lager = prev.lager.overrideAttrs (oldAttrs: {
      cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
        "-Dlager_BUILD_TESTS=OFF"
      ];
      postPatch = (oldAttrs.postPatch or "") + ''
        substituteInPlace CMakeLists.txt \
          --replace-fail "find_package(Boost 1.56 COMPONENTS system REQUIRED)" \
                         "find_package(Boost 1.56 REQUIRED)"
      '';
    });
  };
}
