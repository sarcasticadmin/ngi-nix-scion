{ buildGoModule
, fetchFromGitHub
, openpam
}:

buildGoModule {
  pname = "scion-apps";
  version = "2020-07-29";

  src = fetchFromGitHub {
    owner = "netsec-ethz";
    repo = "scion-apps";
    rev = "3335362c6cb0c8bf6b15d6b2ff5a95fc8acd2d8d";
    sha256 = "1ws72pq3vkmsiyvkbjwakbpfi63wjf0zvjf8amd2sfgjb4c7gc3x";
  };

  buildInputs = [ openpam ];

  goPackagePath = "github.com/netsec-ethz/scion-apps";
  vendorSha256 = "0wk3j1i57s7jvzcpavlhv7n4kdvdqv1qxpydzvwqki9hc8a0dqpr";

  postInstall = ''
    # Include symlinks to the outputs generated by the Makefile
    for f in $out/bin/*; do
      filename="$(basename "$f")"
      ln -s $f $out/bin/scion-$filename
    done

    # Include static website for webapp
    mkdir -p $out/share
    cp -r webapp/web $out/share/scion-webapp
  '';
}
