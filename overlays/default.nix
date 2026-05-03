{ sf-mono-liga-src }:
{
  # This matches 'overlays.sf-mono-liga' in your flake
  sf-mono-liga = final: prev: {
    sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation {
      pname = "sf-mono-liga-bin";
      version = "dev";
      src = sf-mono-liga-src;
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        cp -R $src/*.otf $out/share/fonts/opentype/
      '';
    };
  };

  # This matches 'overlays.lager-boost-fix' in your flake
  lager-boost-fix = final: prev: {
    lager = prev.lager.overrideAttrs (old: {
      cmakeFlags = (old.cmakeFlags or [ ]) ++ [
        "-DCMAKE_DISABLE_FIND_PACKAGE_Boost=ON"
        "-Dlager_BUILD_TESTS=OFF"
      ];
    });
  };

  # This matches 'overlays.wireshark-fix' in your flake
  wireshark-fix = final: prev: {
    wireshark-qt = prev.wireshark-qt.overrideAttrs (old: {
      version = "4.6.5";
      src = prev.fetchFromGitLab {
        owner = "wireshark";
        repo = "wireshark";
        rev = "v4.6.5";
        hash = "sha256-Zvrwxjp4LK2J3QnxmPxKKrU01YHQvPyp54UWzeGNCjA=";
      };
    });
  };
}
