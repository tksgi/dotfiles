{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vimdoc-ja = {
      url = "github:vim-jp/vimdoc-ja";
      flake = false;
    };
    denops = {
      url = "github:vim-denops/denops.vim";
      flake = false;
    };
    skkeleton = {
      url = "github:vim-skk/skkeleton";
      flake = false;
    };
    cmp-skkeleton = {
      url = "github:rinx/cmp-skkeleton";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay = (final: prev: {
        vimPlugins = prev.vimPlugins // {
          vimdoc-ja = buildVimPluginFrom2Nix {
            pname = "vimdoc-ja";
            version = "2023-01-14";
            src = inputs.vimdoc-ja;
          };
          denops = buildVimPluginFrom2Nix {
            pname = "denops";
            version = "2023-01-14";
            src = inputs.denops;
          };
          skkeleton = buildVimPluginFrom2Nix {
            pname = "skkeleton";
            version = "2023-01-14";
            src = inputs.skkeleton;
          };
          cmp-skkeleton = buildVimPluginFrom2Nix {
            pname = "cmp-skkeleton";
            version = "2023-01-14";
            src = inputs.cmp-skkeleton;
          };
        };
      });
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlay ];
      };
      inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
    in
    {
      homeConfigurations.tetsu = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      formatter.x86_64-linux = pkgs.nixpkgs-fmt;
    };
}
