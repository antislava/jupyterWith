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
      name = "Tensorflow";
      packages = p: with p; [
        tensorflow
        tensorflow-core-ops
        tensorflow-proto
        tensorflow-test
        tensorflow-ops
        tensorflow-records
        tensorflow-logging
        tensorflow-mnist
        tensorflow-records-conduit
        HUnit
        datasets
        random-shuffle
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
