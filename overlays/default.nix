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

  wireshark-fix = final: prev: {
    wireshark = prev.wireshark.overrideAttrs (old: {
      version = "4.6.5";
      src = prev.fetchFromGitLab {
        owner = "wireshark";
        repo = "wireshark";
        rev = "v4.6.5";
        hash = "sha256-Zvrwxjp4LK2J3QnxmPxKKrU01YHQvPyp54UWzeGNCjA=";
      };
    });
  };

  tree-sitter-fix = final: prev: {
    # 1. Top-level tree-sitter grammars (just in case)
    tree-sitter-grammars = prev.tree-sitter-grammars // {
      tree-sitter-cuda = prev.tree-sitter-grammars.tree-sitter-cuda.overrideAttrs (oldAttrs: {
        src = oldAttrs.src.overrideAttrs (_: {
          outputHash = "sha256-s2qrZx5fEu/I6xE2paX/Nlmgvo6T27qqvy1cI8iznAA=";
        });
      });
    };

    # 2. Emacs-specific treesit grammars set (THIS is what Emacs uses)
    emacsPackagesFor = emacs: (prev.emacsPackagesFor emacs).overrideScope (efinal: eprev: {
      treesit-grammars = eprev.treesit-grammars // {
        tree-sitter-cuda = eprev.treesit-grammars.tree-sitter-cuda.overrideAttrs (oldAttrs: {
          src = oldAttrs.src.overrideAttrs (_: {
            outputHash = "sha256-s2qrZx5fEu/I6xE2paX/Nlmgvo6T27qqvy1cI8iznAA=";
          });
        });
      };
    });
  };
}
