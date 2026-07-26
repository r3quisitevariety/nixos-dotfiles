# TODO

after installing nix...

curl -sSf -L https://install.lix.systems/lix | sh -s -- install

mv ~/.bashrc ~/.bashrc.backup
mv ~/.bash_profile ~/.bash_profile.backup
mv ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.backup
mv ~/.config/foot/foot.ini ~/.config/foot/foot.ini.backup
mv ~/.local/state/noctalia/settings.toml ~/.local/state/noctalia/settings.toml.backup

cd ~/nixos-dotfiles-2.0 
nix-shell -p nh && nh home switch . 


sudo pacman -S noctalia
sudo pacman -S noctalia-greeter
sudo pacman -S nwg-look
sudo pacman -S qt6ct
sudo pacman -S mpv
sudo pacman -S nautilus
sudo pacman -S vesktop
sudo pacman -S gwenview
sudo pacman -S obs-studio
sudo pacman -S reaper
sudo pacman -S kdenlive
sudo pacman -S krita
sudo pacman -S prismlauncher
sudo pacman -S tailscale

rustup default stable

sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -S wivrn-dashboard
paru -S wivrn-server
paru -S xrizer

