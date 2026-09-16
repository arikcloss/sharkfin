#!/usr/bin/bash

# Tuning baked into every macintosh (Apple Intel Mac 2012-2018) image.
# All of these are static files/systemd units; nothing here needs a network.

set -eou pipefail

# Broadcom Wi-Fi (BCM43xx, e.g. BCM4360 in the 2013-2017 Air/Pro) is handled
# by the mainline open-source drivers (brcmfmac/brcmsmac) with firmware from
# linux-firmware, so no proprietary kmod is needed. Do NOT blacklist ssb/bcma/
# b43 -- brcmsmac depends on them.
cat >/etc/modprobe.d/macintosh-broadcom.conf <<EOF
# Broadcom BCM43xx cards in Intel Macs use the open-source brcmfmac/brcmsmac
# drivers from the mainline kernel; nothing to blacklist here.
EOF

# Apple keyboards: use the F-keys by default (fnmode=2) and assume the
# ANSI layout that Apple's international models carry (iso_layout=0).
cat >/etc/modprobe.d/macintosh-hid-apple.conf <<EOF
# hid_apple options for MacBook keyboards
options hid_apple fnmode=2 iso_layout=0
EOF

# Load the FaceTime HD camera firmware from the initramfs so the PCIe camera
# (Broadcom 1570) is ready immediately after boot.
mkdir -p /etc/dracut.conf.d
cat >/etc/dracut.conf.d/facetimehd.conf <<EOF
install_items+=" /usr/lib/firmware/facetimehd/firmware.bin "
EOF

# Suppress the ACPI wake-up sources (XHC1, LID0) that make old Intel Macs
# wake from suspend immediately; toggling the device name flips its state.
cat >/usr/libexec/sharkfin-mac-wakeup-fix.sh <<'EOF'
#!/usr/bin/bash
for d in XHC1 LID0; do
  if grep -qw "$d" /proc/acpi/wakeup; then
    printf '%s\n' "$d" >/proc/acpi/wakeup
  fi
done
EOF
chmod +x /usr/libexec/sharkfin-mac-wakeup-fix.sh

cat >/etc/systemd/system/sharkfin-mac-wakeup-fix.service <<EOF
[Unit]
Description=Disable spurious ACPI wake sources on Intel Macs
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/libexec/sharkfin-mac-wakeup-fix.sh

[Install]
WantedBy=multi-user.target
EOF
systemctl enable sharkfin-mac-wakeup-fix.service

# Apply PowerTOP auto-tuning on boot for better battery life.
systemctl enable powertop.service