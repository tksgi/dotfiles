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
    back-and-forward = {
      url = "github:Bakudankun/BackAndForward.vim";
      flake = false;
    };
    nerdfont = {
      url = "github:lambdalisue/nerdfont.vim";
      flake = false;
    };
    fern-renderer-nerdfont = {
      url = "github:lambdalisue/fern-renderer-nerdfont.vim";
      flake = false;
    };
    fern-git-status = {
      url = "github:lambdalisue/fern-git-status.vim";
      flake = false;
    };
    fern-mapping-git = {
      url = "github:lambdalisue/fern-mapping-git.vim";
      flake = false;
    };
    fern-hijack = {
      url = "github:lambdalisue/fern-hijack.vim";
      flake = false;
    };
    fern-bookmark = {
      url = "github:lambdalisue/fern-bookmark.vim";
      flake = false;
    };
    fern-mapping-quickfix = {
      url = "github:lambdalisue/fern-mapping-quickfix.vim";
      flake = false;
    };
    fern-preview = {
      url = "github:yuki-yano/fern-preview.vim";
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
          back-and-forward = buildVimPluginFrom2Nix {
            pname = "back-and-forward";
            version = "2023-01-14";
            src = inputs.back-and-forward;
          };
          nerdfont = buildVimPluginFrom2Nix {
            pname = "nerdfont";
            version = "2023-01-14";
            src = inputs.nerdfont;
          };
          fern-renderer-nerdfont = buildVimPluginFrom2Nix {
            pname = "fern-renderer-nerdfont";
            version = "2023-01-14";
            src = inputs.fern-renderer-nerdfont;
          };
          fern-git-status = buildVimPluginFrom2Nix {
            pname = "fern-git-status";
            version = "2023-01-14";
            src = inputs.fern-git-status;
          };
          fern-mapping-git = buildVimPluginFrom2Nix {
            pname = "fern-mapping-git";
            version = "2023-01-14";
            src = inputs.fern-mapping-git;
          };
          fern-hijack = buildVimPluginFrom2Nix {
            pname = "fern-hijack";
            version = "2023-01-14";
            src = inputs.fern-hijack;
          };
          fern-bookmark = buildVimPluginFrom2Nix {
            pname = "fern-bookmark";
            version = "2023-01-14";
            src = inputs.fern-bookmark;
          };
          fern-mapping-quickfix = buildVimPluginFrom2Nix {
            pname = "fern-mapping-quickfix";
            version = "2023-01-14";
            src = inputs.fern-mapping-quickfix;
          };
          fern-preview = buildVimPluginFrom2Nix {
            pname = "fern-preview";
            version = "2023-01-14";
            src = inputs.fern-preview;
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
