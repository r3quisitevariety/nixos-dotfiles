#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "==> Installing Nix..."
curl -sSf -L https://install.lix.systems/lix | sh -s -- install

 shellcheck disable=SC1091
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

echo "==> Backing up existing configs..."
for f in \
    ~/.bashrc \
    ~/.bash_profile \
    ~/.config/hypr/hyprland.lua \
    ~/.config/foot/foot.ini \
    ~/.local/state/noctalia/settings.toml; do
    if [[ -e "$f" ]]; then mv "$f" "$f.backup"; fi
done

echo "==> Switching home-manager config..."
cd "$DOTFILES_DIR"
nix-shell -p nh --run "nh home switch ."

echo "==> Installing pacman packages..."
sudo pacman -S --needed --noconfirm \
    noctalia \
    noctalia-greeter \
    nwg-look \
    adw-gtk-theme \
    mpv \
    nautilus \
    vesktop \
    gwenview \
    obs-studio \
    reaper \
    kdenlive \
    krita \
    prismlauncher \
    tailscale

echo "==> Setting up Rust..."
rustup default stable

echo "==> Building paru (AUR helper)..."
sudo pacman -S --needed --noconfirm base-devel git
PARU_DIR="$(mktemp -d)"
git clone https://aur.archlinux.org/paru.git "$PARU_DIR/paru"
pushd "$PARU_DIR/paru"
makepkg -si --needed --noconfirm
popd
rm -rf "$PARU_DIR"

echo "==> Installing AUR packages..."
paru -S --needed --noconfirm \
    wivrn-dashboard \
    wivrn-server \
    xrizer \
    qt6ct-kde \
    proton-rtsp-bin


echo "==> Enabling port 9757 for WiVrn..."
sudo ufw allow 9757

echo "==> Done!"
