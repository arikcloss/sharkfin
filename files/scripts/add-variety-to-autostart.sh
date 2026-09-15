#!/usr/bin/bash

set -eou pipefail
 
mkdir -p /etc/skel/.config/autostart
cp /usr/share/applications/variety.desktop /etc/skel/.config/autostart/