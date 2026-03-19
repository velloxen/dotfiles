# https://nixos.wiki/wiki/Packaging/Python
{
  lib,
  pkgs,
  buildPythonPackage,
  fetchPypi,
  ...
}:
buildPythonPackage rec {
  pname = "subs2cia";
  version = "0.5.0";

  src = fetchPypi {
    inherit pname version;
    # The easiest way to get the sha256 is to build it and let it fail
    # the error message should include the correct sha256
    sha256 = "sha256-Noj7rJA5GiwgCGYoqH8dtxkvNRyD7PxutCfSFdGrLRU=";
  };

  format = "pyproject";
  build-system = [ pkgs.python3Packages.setuptools ];

  # Added to $PYTHONPATH
  # think, requirements.txt
  pythonPath = with pkgs.python3Packages; [
    ffmpeg-python
    pycountry
    pysubs2
    setuptools
    tqdm
    pandas
    gevent
    colorlog
  ];

  # ffmpeg-python needs ffmpeg to be in $PATH
  # this does that
  propagatedBuildInputs = [ pkgs.ffmpeg ];

  meta = {
    description = "Extract subtitled dialogue from audiovisual media for use in language acquisition";
    homepage = "https://github.com/dxing97/subs2cia";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    badPlatforms = [ ];
  };
}
