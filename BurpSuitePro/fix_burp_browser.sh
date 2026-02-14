#!/bin/bash

echo "[*] Searching for chrome-sandbox..."
SANDBOX_PATH=$(find ./ -type f -name "chrome-sandbox" 2>/dev/null | head -n 1)

if [ -z "$SANDBOX_PATH" ]; then
  echo "[!] chrome-sandbox not found"
  echo "[!] Try locating it manually or check if the embedded browser is installed correctly."
  exit 1
fi

echo "[+] Found: $SANDBOX_PATH"

# Check current ownership and permissions
CURRENT_OWNER=$(stat -c '%U:%G' "$SANDBOX_PATH")
CURRENT_PERMS=$(stat -c '%a' "$SANDBOX_PATH")

if [ "$CURRENT_OWNER" == "root:root" ] && [ "$CURRENT_PERMS" == "4755" ]; then
  echo "[*] Permissions and ownership already correctly set."
  echo "[*] If Burp is running, close and reopen it for changes to take effect."
  exit 0
fi

echo "[*] Current owner: $CURRENT_OWNER"
echo "[*] Current permissions: $CURRENT_PERMS"
echo "[*] Applying required changes..."

sudo chown root:root "$SANDBOX_PATH"
sudo chmod 4755 "$SANDBOX_PATH"

# Re-check after applying
NEW_OWNER=$(stat -c '%U:%G' "$SANDBOX_PATH")
NEW_PERMS=$(stat -c '%a' "$SANDBOX_PATH")

if [ "$NEW_OWNER" == "root:root" ] && [ "$NEW_PERMS" == "4755" ]; then
  echo "[+] Permissions successfully updated."
  echo "[*] If Burp Suite is open, make sure to close and reopen it."
else
  echo "[!] Failed to apply changes. Please check manually:"
  ls -l "$SANDBOX_PATH"
  exit 1
fi
