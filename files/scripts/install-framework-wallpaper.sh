#!/usr/bin/bash

set -eou pipefail

curl -fL --retry 5 --retry-delay 5 --retry-all-errors \
  https://downloads.frame.work/assets/framework-laptop12-wallpaper-pack.zip > /tmp/framework-12-wallpapers.zip

mkdir -p /usr/share/backgrounds/framework
cd /usr/share/backgrounds/framework
unzip /tmp/framework-12-wallpapers.zip