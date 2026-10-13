#!/usr/bin/env bash
# TerraSense EC2 one-shot setup. Run as the default ubuntu user on a fresh
# Ubuntu 22.04/24.04 t3.small instance. Idempotent - safe to re-run for
# updates (git pull + service restart).
#
# After it finishes, copy the printed https://...trycloudflare.com URL into
# Vercel's VITE_API_BASE env var and redeploy the frontend.
set -euo pipefail

REPO="https://github.com/VPK570/TerraSense-SDG.git"
APP_DIR="/opt/terrasense"
SVC="terrasense"

echo "==> Installing system packages"
sudo apt-get update -qq
sudo apt-get install -y -qq python3-venv python3-pip curl git

echo "==> Syncing repo to $APP_DIR"
if [ -d "$APP_DIR/.git" ]; then
  git -C "$APP_DIR" pull --ff-only
else
  sudo mkdir -p "$APP_DIR"
  sudo chown "$USER:$USER" "$APP_DIR"
  git clone "$REPO" "$APP_DIR"
fi

echo "==> Creating venv and installing Python deps"
cd "$APP_DIR/backend"
python3 -m venv .venv
.venv/bin/pip install -q --upgrade pip
.venv/bin/pip install -q -r requirements.txt

echo "==> Installing gunicorn systemd unit (binds to localhost:5000)"
sudo tee /etc/systemd/system/$SVC.service > /dev/null <<EOF
[Unit]
Description=TerraSense Flask backend
After=network.target

[Service]
User=$USER
WorkingDirectory=$APP_DIR/backend
ExecStart=$APP_DIR/backend/.venv/bin/gunicorn --workers 1 --threads 8 --bind 127.0.0.1:5000 app:app
Restart=always
Environment=PORT=5000
Environment=FLASK_DEBUG=false

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now $SVC
sudo systemctl restart $SVC

echo "==> Installing cloudflared (free HTTPS tunnel, no open inbound ports)"
if ! command -v cloudflared > /dev/null 2>&1; then
  curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -o /tmp/cloudflared.deb
  sudo dpkg -i /tmp/cloudflared.deb
  rm -f /tmp/cloudflared.deb
fi

sudo tee /etc/systemd/system/cloudflared.service > /dev/null <<EOF
[Unit]
Description=Cloudflare quick tunnel to TerraSense
After=network.target

[Service]
User=$USER
ExecStart=/usr/bin/cloudflared tunnel --url http://127.0.0.1:5000
Restart=always

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now cloudflared
sudo systemctl restart cloudflared

echo "==> Waiting for tunnel to come up..."
sleep 6

echo ""
echo "==> Backend health check:"
curl -s http://127.0.0.1:5000/api/health || echo "backend not ready yet - check: sudo systemctl status $SVC"

echo ""
echo "==> YOUR PUBLIC HTTPS BACKEND URL (paste into Vercel VITE_API_BASE):"
URL=$(sudo journalctl -u cloudflared -n 50 --no-pager 2>/dev/null | grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' | tail -1 || true)
if [ -n "$URL" ]; then
  echo "    $URL"
else
  echo "    (not found in logs yet - run: sudo journalctl -u cloudflared -f)"
fi

echo ""
echo "==> Done. Notes:"
echo "    - Tunnel URL changes if cloudflared restarts; re-run this script"
echo "      and update Vercel's VITE_API_BASE if that happens."
echo "    - After the event: terminate this EC2 instance in the AWS console"
echo "      so you stop burning credits."
