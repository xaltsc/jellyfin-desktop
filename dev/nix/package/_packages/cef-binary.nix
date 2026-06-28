{ cef-binary }:
let
  version = "149.0.4";
in
(
  if (cef-binary.version == version) then
    cef-binary
  else
    (cef-binary.override {
      inherit version;
      gitRevision = "6770623";
      chromiumVersion = "149.0.7827.197";
      srcHashes = {
        aarch64-linux = "sha256-ZORvcvs1rAg5EKJkCt81RZYupCWpUNIC/nLt3PJow7Q="; # cBA
        x86_64-linux = "sha256-ZORMBJmvvLiLdBDniBQwx7LmTGGI59AcesJdILSeqcs="; # OPG
      };
    })
).overrideAttrs
  (old: {
    # make nix understand that src and version are defined in this file
    inherit (old) src version;

    passthru = old.passthru // {
      updateScript = ./update-cef.sh;
    };
  })
