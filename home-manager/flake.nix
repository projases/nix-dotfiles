{
  description = "Home Manager configuration for pablo";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    #nix-colors.url = "github:misterio77/nix-colors";
    # zen-browser.url = "github:MarceColl/zen-browser-flake";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs-unstable, home-manager, zen-browser, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs-unstable.legacyPackages.${system};
    in {
      homeConfigurations = {
        pablo = home-manager.lib.homeManagerConfiguration {
          # inherit pkgs-unstable;
          pkgs = nixpkgs-unstable.legacyPackages.${system};
          # pkgs = import nixpkgs{
          #   system = "x86_64-linux";
          # }
          # ;

          modules = [
            ./home.nix
          ];

          extraSpecialArgs = { inherit zen-browser; };
        };
      };
    };
}
