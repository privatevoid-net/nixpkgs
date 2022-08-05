{ lib, stdenv, fetchurl, fetchpatch, pkg-config, autoreconfHook, intltool, gnome
, iconnamingutils, gtk3, gdk-pixbuf, librsvg, hicolor-icon-theme }:

stdenv.mkDerivation rec {
  pname = "adwaita-icon-theme";
  version = "43.beta";

  src = fetchurl {
    url = "mirror://gnome/sources/adwaita-icon-theme/${lib.versions.major version}/${pname}-${version}.tar.xz";
    sha256 = "Ky3t0XQHefoG1ysA0QcbidFyundiqKF1YxUtHf1JXZY=";
  };

  patches = [
    (fetchpatch {
      name = "reduce-build-parallelism.patch";
      url = "https://gitlab.gnome.org/vcunat/adwaita-icon-theme/-/commit/27edeca7927eb2247d7385fccb3f0fd7787471e6.patch";
      sha256 = "vDWuvz5yRhtn9obTtHRp6J7gJpXDZz1cajyquPGw53I=";
    })
  ];

  # For convenience, we can specify adwaita-icon-theme only in packages
  propagatedBuildInputs = [ hicolor-icon-theme ];

  buildInputs = [ gdk-pixbuf librsvg ];

  nativeBuildInputs = [ pkg-config autoreconfHook intltool iconnamingutils gtk3 ];

  dontDropIconThemeCache = true;

  # remove a tree of dirs with no files within
  postInstall = '' rm -rf "$out/locale" '';

  passthru = {
    updateScript = gnome.updateScript {
      packageName = "adwaita-icon-theme";
      attrPath = "gnome.adwaita-icon-theme";
    };
  };

  meta = with lib; {
    platforms = with platforms; linux ++ darwin;
    maintainers = teams.gnome.members;
  };
}
