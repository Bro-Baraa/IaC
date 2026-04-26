#!/bin/bash
# Runs once on first boot via cloud-init.
# Installs nginx and drops a small landing page.

set -euo pipefail

apt-get update -y
apt-get install -y nginx

systemctl enable nginx
systemctl start nginx

cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Baraa - Azure IaaS Lab</title>
  <style>
    body { font-family: system-ui, sans-serif; margin: 3rem; color: #222; }
    code { background: #eee; padding: 0.1rem 0.3rem; border-radius: 3px; }
  </style>
</head>
<body>
  <h1>It works!</h1>
  <p>Hello from Baraa's private Azure VM.</p>
  <p>This page is served by nginx, running on a VM with no public IP.</p>
  <p>You reached it through the jumpbox - which is the whole point.</p>
</body>
</html>
HTML
