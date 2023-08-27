let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };

  pre-commit-check = (import sources.pre-commit-hooks).run {
    src = ./.;

    hooks = {
      nixfmt.enable = true;
      statix.enable = true;

      rustfmt.enable = true;
      clippy.enable = true;

      commitizen.enable = true;
    };
  };

in pkgs.mkShell {
  packages = with pkgs; [ rustc cargo ];

  shellHook = ''
    ${pre-commit-check.shellHook}
  '';
}
