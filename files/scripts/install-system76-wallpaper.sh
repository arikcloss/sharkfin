#!/usr/bin/bash
set -euo pipefail

curl -L https://system76.com/content/downloads/System76-Wallpapers.zip > /tmp/System76-Wallpapers.zip
mkdir -p /usr/share/backgrounds/system76
cd /usr/share/backgrounds/system76
unzip /tmp/System76-Wallpapers.zip