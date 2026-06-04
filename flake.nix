{
  description = "Athi's CachyOS home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."aboog" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
          }
          ./home.nix
        ];
      };
    };
}