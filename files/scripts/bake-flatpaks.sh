#!/usr/bin/bash
set -euo pipefail

# Bakes the Flatpak apps into the image itself (system scope), so they are
# already present on first boot / on the live ISO instead of being installed
# at runtime.

flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install --system --noninteractive --assumeyes flathub \
    org.gtk.Gtk3theme.adw-gtk3 \
    org.gtk.Gtk3theme.adw-gtk3-dark \
    org.gnome.Firmware \
    io.missioncenter.MissionCenter \
    org.cockpit_project.CockpitClient \
    org.gnome.Logs \
    org.gnome.Calculator \
    org.gnome.TextEditor \
    org.gnome.font-viewer \
    org.gnome.FileRoller \
    ca.desrt.dconf-editor \
    com.github.tchx84.Flatseal \
    com.mattjakeman.ExtensionManager \
    org.gnome.Weather \
    org.gnome.Papers \
    org.gnome.Loupe \
    org.gnome.baobab \
    com.github.rafostar.Clapper \
    org.gnome.Snapshot \
    org.libreoffice.LibreOffice \
    org.fedoraproject.MediaWriter \
    io.github.flattool.Warehouse \
    io.github.kolunmi.Bazaar \
    org.gnome.SimpleScan \
    org.gustavoperedo.FontDownloader \
    org.gnome.NautilusPreviewer \
    com.github.PintaProject.Pinta \
    org.gnome.clocks \
    org.gnome.Connections \
    org.gnome.DejaDup \
    com.discordapp.Discord \
    com.spotify.Client \
    com.brave.Browser \
    org.gimp.GIMP \
    org.audacityteam.Audacity \
    org.darktable.Darktable \
    io.dbeaver.DBeaverCommunity \
    com.ranfdev.DistroShelf \
    sh.loft.devpod \
    me.iepure.devtoolbox \
    io.podman_desktop.PodmanDesktop

flatpak remove --system --noninteractive --assumeyes org.fedoraproject.FedoraAppStreamData 2>/dev/null || true