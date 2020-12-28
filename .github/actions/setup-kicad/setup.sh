#!/usr/bin/env bash

set -e

case $1 in
  'v5')
    sudo add-apt-repository --yes ppa:kicad/kicad-5.1-releases
    sudo apt-get update
    sudo apt-get install --yes --no-install-recommends kicad
    ;;

  'nightly')
    sudo add-apt-repository --yes ppa:kicad/kicad-dev-nightly
    sudo apt-get update
    sudo apt-get install --yes --no-install-recommends kicad-nightly
    echo "PYTHONPATH=/usr/lib/kicad-nightly/lib/python3/dist-packages/" >> $GITHUB_ENV
    for $bin in kicad pcbnew eeschema; do
        sudo ln -s /usr/bin/$bin-nightly /usr/bin/$bin
    done
    ;;

  *)
    echo "Invalid version '$1' passed. Only 'v5' and 'nightly' supported" >&2
    exit 1
    ;;
esac
