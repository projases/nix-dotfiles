{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:projases/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    opencode-nix.url = "github:dominicnunez/opencode-nix";

    nix-claude-code.url = "github:ryoppippi/nix-claude-code";

  };

  outputs = { self, nixpkgs, home-manager, sf-mono-liga-src, zen-browser, opencode-nix, nix-claude-code, ... }@inputs:

  let 
    overlays = import ./overlays { inherit sf-mono-liga-src; };

  mkHost = hostPath: nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };

    modules = [
      "${hostPath}/hardware-configuration.nix"
      "${hostPath}/configuration.nix"

      # make overlay visible to this host
      { nixpkgs.overlays = [
          overlays.sf-mono-liga
          overlays.lager-boost-fix
          overlays.wireshark-fix
          inputs.opencode-nix.overlays.default
          inputs.nix-claude-code.overlays.default
        ];
      }

      inputs.noctalia.nixosModules.default

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.pablo = import ./home-manager/home.nix;
          extraSpecialArgs = { inherit inputs zen-browser; };
        };
      }
    ];
  };
  in {
    nixosConfigurations.laniakea = mkHost ./systems/laniakea;
    nixosConfigurations.macnix  = mkHost ./systems/macnix;
  };
}
