# Google Antigravity 2.x Installer for Ubuntu / Debian

Automated installation, sandbox permission fixes, and GNOME desktop integration for Google Antigravity 2.x on Ubuntu.

---

## Why This Script Exists

Installing Antigravity 2.x on Linux currently encounters three major friction points:

1. **Outdated Package Managers:** The official APT repository (`antigravity-debian`) only ships legacy `1.x` builds, while version `2.x+` is distributed via manual tarballs.
2. **Electron SUID Sandbox Crash:** Extracting the tarball leaves `/opt/Antigravity-x64/chrome-sandbox` without root ownership and SUID mode (`4755`), causing the application to crash on launch with `FATAL:setuid_sandbox_host.cc: The SUID sandbox helper binary was found, but is not configured correctly`.
3. **Missing or Low-Res Icon:** UI visual assets are compiled into binary archives (`resources.pak`), leaving the desktop launcher icon blank. Using web favicons produces blurry 32×32 pixel bitmaps on high-DPI GNOME dashboards.

---

## What This Script Does

* Extracts `Antigravity*.tar.gz` directly into `/opt/Antigravity-x64`.
* Creates a system-wide symlink at `/usr/local/bin/antigravity`.
* Configures `chrome-sandbox` with `chown root:root` and `chmod 4755`.
* Installs the official vector SVG brandmark directly into `/usr/share/icons/hicolor/scalable/apps/antigravity.svg` for sharp rendering at all resolutions.
* Generates a FreeDesktop-compliant `/usr/share/applications/antigravity.desktop` file.
* Updates `gtk-update-icon-cache` and flushes user thumbnail caches.

---

## Prerequisites

1. Download the official Linux tarball (`Antigravity*.tar.gz`) from:  
   **[https://antigravity.google/download](https://antigravity.google/download)**
2. Ensure the downloaded `.tar.gz` file is located in your `~/Downloads` directory.

---

## Quick Install

Run directly via `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/anjanatharusha/antigravity-ubuntu-installer/main/install-antigravity.sh | bash
