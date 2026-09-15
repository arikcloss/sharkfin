#!/usr/bin/bash

set -oue pipefail 
# Part of an attempt to add Google Chrome in the usual way.
echo "Fixing google-chrome yum repo"
chrome_repo="/etc/yum.repos.d/google-chrome.repo"
if [[ -f "$chrome_repo" ]]; then
    sed -i '/enabled/d' "$chrome_repo"
    echo "enabled=1" >> "$chrome_repo"
else
    cat > "$chrome_repo" <<'EOF'
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF
fi