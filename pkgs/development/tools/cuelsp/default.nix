{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "cuelsp";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "dagger";
    repo = "cuelsp";
    rev = "v${version}";
    sha256 = "sha256-78snbfxm6nSNDQRhj7cC4FSkKeOEUw+wfjhJtP/CpwY=";
  };

  vendorSha256 = "sha256-zg4aXPY2InY5VEX1GLJkGhMlfa5EezObAjIuX/bGvlc=";

  doCheck = false;

  subPackages = [
    "cmd/cuelsp"
  ];

  meta = with lib; {
    description = "Language Server implementation for CUE, with built-in support for Dagger";
    homepage = "https://github.com/dagger/cuelsp";
    license = licenses.asl20;
    maintainers = with maintainers; [ sagikazarmark ];
  };
}
