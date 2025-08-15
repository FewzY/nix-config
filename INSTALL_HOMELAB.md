# Installation Instructions for Your NixOS Homelab

## On your Mac:

1. First, commit and push your changes:
```bash
cd /Users/fewzy/Dev/playground/nix-config
git add .
git commit -m "Add homelab machine configuration"
git push origin main
```

2. Get your SSH public key:
```bash
cat ~/.ssh/id_rsa.pub
# Copy this output
```

## On the NixOS installer:

1. Replace the nix-config on the installer:
```bash
# Remove the old one
rm -rf /mnt/etc/nixos

# Clone YOUR fork
git clone https://github.com/fewzy/nix-config.git /mnt/etc/nixos

# Generate hardware config
sudo nixos-generate-config --root /mnt --dir /tmp

# Copy the hardware config to your repo
cp /tmp/hardware-configuration.nix /mnt/etc/nixos/

# Create SSH directory for fewzy
mkdir -p /mnt/home/fewzy/.ssh

# Add your SSH public key (paste the one you copied from Mac)
echo "YOUR_SSH_PUBLIC_KEY_HERE" > /mnt/home/fewzy/.ssh/id_rsa.pub
chmod 600 /mnt/home/fewzy/.ssh/id_rsa.pub
```

2. Install NixOS:
```bash
sudo nixos-install --root /mnt --flake /mnt/etc/nixos#homelab
```

3. When prompted, set the root password.

4. After installation completes:
```bash
sudo reboot
# Remove USB when prompted
```

## After first boot:

1. Login as root with the password you set

2. Set fewzy's password:
```bash
passwd fewzy
```

3. Switch to fewzy user:
```bash
su - fewzy
```

4. Connect to Tailscale:
```bash
sudo tailscale up
```

5. Check services:
```bash
systemctl status docker
systemctl status jellyfin
# etc.
```

6. Access your services:
- Homepage dashboard: http://homelab.local or http://YOUR_IP
- Jellyfin: http://homelab.local:8096
- Vaultwarden: http://homelab.local:8222
- Other services will be listed on the homepage

## To enable/disable services:

Edit `/etc/nixos/machines/nixos/homelab/homelab/default.nix` and set services to true/false, then:
```bash
sudo nixos-rebuild switch --flake /etc/nixos#homelab
```

## Setting up your HDDs later:

1. When you connect your HDDs, identify them:
```bash
lsblk
sudo fdisk -l
```

2. Create ZFS pool for data (recommended for your HDDs):
```bash
sudo zpool create -o ashift=12 storage mirror /dev/sdb /dev/sdc
sudo zfs create storage/media
sudo zfs create storage/downloads
sudo zfs create storage/documents
sudo chown -R fewzy:fewzy /storage
```

Or use ext4 if you prefer simplicity.
