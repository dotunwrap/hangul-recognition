{ inputs, ... }:
{
  perSystem =
    { runCommand, pkgs, ... }:
    let
      inherit (inputs) self;
    in
    {
      checks = {
        nixfmt = pkgs.runCommand "check-nixfmt-${self.rev or "dirty"}" { } ''
          ${pkgs.nixfmt}/bin/nixfmt --check ${self} < /dev/null | tee $out
        '';
        oxfmt = pkgs.runCommand "check-oxfmt-${self.rev or "dirty"}" { } ''
          ${pkgs.bun}/bin/bun run fmt:check ${self} < /dev/null | tee $out
        '';
        lint = pkgs.runCommand "check-lint-${self.rev or "dirty"}" { } ''
          ${pkgs.bun}/bin/bun run lint ${self} < /dev/null | tee $out
        '';
      };
    };
}
