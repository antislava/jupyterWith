let
  jupyterLibPath = ../../..;
  nixpkgsPath = jupyterLibPath + "/nix";
  pkgs = import nixpkgsPath { config = { allowBroken = true; }; };
  jupyter = import jupyterLibPath {
    pkgs=pkgs;
    # Added to master 2019-10. TODO test this overlay.nix
    # overlays = [ (import ./overlay.nix) ];
  };

  ihaskellWithPackages = jupyter.kernels.iHaskellWith {
      name = "Frames";
      packages = p: with p; [
        foldl
        Frames
      ];
    };

  jupyterlabWithKernels =
    jupyter.jupyterlabWith {
      kernels = [ ihaskellWithPackages ];
      directory = jupyter.mkDirectoryWith {
        extensions = [
          "jupyterlab-ihaskell"
        ];
      };
    };
in
  jupyterlabWithKernels.env
