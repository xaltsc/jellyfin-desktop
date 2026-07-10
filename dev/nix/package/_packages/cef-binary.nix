{ cef-binary }:
let
  version = "150.0.10";
in
(
  if (cef-binary.version == version) then
    cef-binary
  else
    (cef-binary.override {
      inherit version;
      gitRevision = "8042e43";
      chromiumVersion = "150.0.7871.101";
      srcHashes = {
        aarch64-linux = "sha256-+5U2KskaH3GuaoyLpNBkHK0IN1kExOfdHMPO67Gi2HU=";
        x86_64-linux = "sha256-bB1Ike84huPM9l0JKI2DBOP343JKR8kyk+K9Y+dlKOQ=";
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
