#!/usr/bin/bash

# Make the modern Plasma wallpapers and the historical KDE ones (from the
# kde-wallpapers and plasma-workspace-wallpapers packages) selectable in the
# GNOME background chooser and usable by Variety, by flattening them into
# /usr/share/backgrounds/kde

set -eou pipefail

mkdir -p /usr/share/backgrounds/kde
find /usr/share/wallpapers -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) -exec cp -n {} /usr/share/backgrounds/kde/ \;
du -sh /usr/share/backgrounds/kde