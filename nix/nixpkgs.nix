let
  src = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/bf3360cdcfee144ce349457b248de3b93aee3c3d.tar.gz";
    sha256 = "0dwxk6hhqvma9l8nfpg01qdlz6iswnswj8as0d5yim1wmvplg6sy";
  };
in
  import src
