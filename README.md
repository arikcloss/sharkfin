# sharkfin &nbsp; [![bluebuild build badge](https://github.com/arikcloss/sharkfin/actions/workflows/build-daily.yml/badge.svg)](https://github.com/arikcloss/sharkfin/actions/workflows/build-daily.yml)

These are [Bootable Container](https://containers.github.io/bootable/) images built from [Universal Blue](https://universal-blue.org) base images with [BlueBuild](https://blue-build.org)'s tools. The images contain either the [Fedora Silverblue](https://silverblue.fedoraproject.org), [Bluefin](https://projectbluefin.io), or [Bazzite](https://bazzite.gg) operating system with my personal preferences baked in. The image based on Bluefin DX (`sharkfin-bluefin`) is my daily driver. All images get a similar GNOME desktop experience.

Modifications common to all images:

-   Google Chrome RPM installed and set as default browser
-   [Variety](https://peterlevi.com/variety/) wallpaper changer (installed as RPM for now)
-   Clocks set to AM/PM view with Weekday Display
-   Curated selection of Flatpak apps installed automatically at runtime (this overrides Bluefin's default flatpak choices)
-   Single click to open items in Nautilus
-   Use smaller icons in Nautilus icon view
-   Sort directories first in Nautilus and GTK file choosers
-   Dark styles enabled by default
-   [System76 wallpaper collection](https://system76.com/merch/desktop-wallpapers)
-   [Framework 12](https://frame.work/laptop12) wallpapers
-   Historical Ubuntu wallpapers, mostly from the LTS versions
-   Historical KDE and modern Plasma wallpaper collections
-   [Intel One Mono](https://www.intel.com/content/www/us/en/company-overview/one-monospace-font.html) set as default monospace font

For the Silverblue Images (`ghcr.io/arikcloss/sharkfin`):

-   Visual Studio Code RPM installed
-   Libvirt/Virt-Manager installed on host
-   Docker CE installed with rootful Docker disabled
-   Dash-to-Dock enabled by default, skipping Overview on login
-   Appindicators enabled by default
-   Logo Menu enabled by default (like Bluefin)
-   Windows have minimize and maximize buttons (like Ubuntu and Bluefin)
-   Additional packages (e.g. Firewall GUI, rclone/restic, Universal Blue enhancements)
-   `<CTRL><ALT>t` opens a terminal

For the Bluefin Images (`ghcr.io/arikcloss/sharkfin-bluefin`):

-   Starship disabled by default (users can enable if needed)
-   Rootful Docker disabled. Users can set up [rootless Docker](https://docs.docker.com/engine/security/rootless/) for themselves.
-   A different list of default flatpaks

For the Bazzite Image (`ghcr.io/arikcloss/sharkfin-bazzite`)

-   GNOME desktop with similar UI to the other images
-   Developer mode enabled (i.e. based on `bazzite-dx-gnome`)
-   Steam does not autostart on login

## Which Image? Which Version?

Fedora Silverblue:

-   `ghcr.io/arikcloss/sharkfin:gts` -- Fedora 43, updated weekly
-   `ghcr.io/arikcloss/sharkfin:latest` -- Fedora 44, updated daily

Bluefin (see [Bluefin's docs](https://docs.projectbluefin.io/administration#upgrades-and-throttle-settings) for more details):

-   `ghcr.io/arikcloss/sharkfin-bluefin:gts` -- [Bluefin GTS](https://docs.projectbluefin.io/administration#bluefin-gts) with developer tools ("DX image"), updated weekly
-   `ghcr.io/arikcloss/sharkfin-bluefin:stable` -- Bluefin Stable with developer tools, updated weekly
-   `ghcr.io/arikcloss/sharkfin-bluefin:latest` -- Bluefin Latest with developer tools, updated daily

Bazzite: `ghcr.io/arikcloss/sharkfin-bazzite` -- Bazzite DX GNOME stable, updated weekly

## Installation

First, install any [Fedora Atomic](https://fedoraproject.org/atomic-desktops/) or [Universal Blue](https://universal-blue.org) desktop edition (preferably one that features GNOME, like Silverblue or Bluefin).

Then use `bootc switch` to switch to the image you want. For example:

```
sudo bootc switch ghcr.io/arikcloss/sharkfin:gts --enforce-container-sigpolicy
```

Then reboot

```
systemctl reboot
```

## Installing via ISO

If you have `podman` installed on your system, you can generate an offline ISO with the `download-iso.sh` script in this directory, like this:

```
./download-iso.sh $IMAGE_NAME $TAG_NAME
```

where `$IMAGE_NAME` is one of `sharkfin`, `sharkfin-bluefin`, or `sharkfin-bazzite` and `TAG_NAME` corresponds to `stable` (`sharkfin-bluefin` image only), `gts`, or `latest`.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```
cosign verify --key cosign.pub ghcr.io/arikcloss/sharkfin:gts
cosign verify --key cosign.pub ghcr.io/arikcloss/sharkfin:latest
cosign verify --key cosign.pub ghcr.io/arikcloss/sharkfin-bluefin:gts
cosign verify --key cosign.pub ghcr.io/arikcloss/sharkfin-bluefin:stable
cosign verify --key cosign.pub ghcr.io/arikcloss/sharkfin-bluefin:latest
cosign verify --key cosign.pub ghcr.io/arikcloss/sharkfin-bazzite
```

## Building Locally

```
./build-image.sh [recipe file]
```