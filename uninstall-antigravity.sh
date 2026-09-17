cat << 'EOF' > uninstall-antigravity.sh
#!/usr/bin/env bash
set -euo pipefail

echo "==> Starting Google Antigravity 2.x uninstallation..."

# 1. Terminate running instances
if pgrep -f "/opt/Antigravity-x64/antigravity" > /dev/null 2>&1; then
  echo "==> Stopping running Antigravity processes..."
  pkill -f "/opt/Antigravity-x64/antigravity" || true
fi

# 2. Remove application directory
if [[ -d "/opt/Antigravity-x64" ]]; then
  echo "==> Removing /opt/Antigravity-x64..."
  sudo rm -rf /opt/Antigravity-x64
fi

# 3. Remove global execution symlink
if [[ -L "/usr/local/bin/antigravity" || -f "/usr/local/bin/antigravity" ]]; then
  echo "==> Removing symlink /usr/local/bin/antigravity..."
  sudo rm -f /usr/local/bin/antigravity
fi

# 4. Remove desktop launcher entry
if [[ -f "/usr/share/applications/antigravity.desktop" ]]; then
  echo "==> Removing /usr/share/applications/antigravity.desktop..."
  sudo rm -f /usr/share/applications/antigravity.desktop
fi

# 5. Remove vector SVG icon from theme
if [[ -f "/usr/share/icons/hicolor/scalable/apps/antigravity.svg" ]]; then
  echo "==> Removing /usr/share/icons/hicolor/scalable/apps/antigravity.svg..."
  sudo rm -f /usr/share/icons/hicolor/scalable/apps/antigravity.svg
fi

# 6. Rebuild system desktop and icon databases
echo "==> Rebuilding desktop database and icon caches..."
sudo update-desktop-database
sudo gtk-update-icon-cache -f /usr/share/icons/hicolor 2>/dev/null || true
rm -rf "$HOME/.cache/thumbnails/*" "$HOME/.cache/icon-cache.kcache" 2>/dev/null || true

# 7. Optional cleanup prompt for configuration and cache data
read -rp "Do you want to delete local user configuration and logs (~/.config/Antigravity)? [y/N]: " cleanup_data
if [[ "$cleanup_data" =~ ^[Yy]$ ]]; then
  echo "==> Removing user configuration and cache files..."
  rm -rf "$HOME/.config/Antigravity"
fi

echo "==> Complete! Antigravity 2.x has been cleanly removed."
EOF
chmod +x uninstall-antigravity.sh
