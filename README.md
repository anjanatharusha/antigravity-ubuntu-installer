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

* **Automated Package Resolution:** Checks `~/Downloads` for an existing `Antigravity*.tar.gz`; if not present, downloads the latest archive automatically.
* **Installation:** Extracts the package cleanly into `/opt/Antigravity-x64`.
* **Global CLI Access:** Creates a system-wide symlink at `/usr/local/bin/antigravity`.
* **Sandbox Configuration:** Sets `chown root:root` and `chmod 4755` on `chrome-sandbox`.
* **Vector Icon Integration:** Installs the official vector SVG brandmark directly into `/usr/share/icons/hicolor/scalable/apps/antigravity.svg` for sharp rendering across all display scales.
* **Desktop Launcher:** Generates a FreeDesktop-compliant `/usr/share/applications/antigravity.desktop` entry.
* **Cache Rebuilding:** Triggers `gtk-update-icon-cache`, `update-desktop-database`, and clears stale thumbnail caches.

---

## Quick Install

Run directly via `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/anjanatharusha/antigravity-ubuntu-installer/main/install-antigravity.sh | bash
