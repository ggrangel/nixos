# NixOS server setup

1. **Clone NixOS config**
   ```bash
   git clone https://github.com/ggrangel/nixos.git /tmp/nixos
   sudo cp -r /tmp/nixos/* /etc/nixos/
   ```

2. **Add Home Manager channel**
   ```bash
   sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
   sudo nix-channel --update
   ```

3. **Apply NixOS configuration**
   ```bash
   sudo nixos-rebuild switch
   ```

4. **Generate SSH keys for GitHub**
   ```bash
   ssh-keygen -t ed25519 -C "gustavorangel91@gmail.com" -f ~/.ssh/$(hostname)
   ssh-keygen -t ed25519 -C "gustavorangel91@gmail.com" -f ~/.ssh/ggrangel-git-signing
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/$(hostname)
   ssh-add ~/.ssh/ggrangel-git-signing
   cat ~/.ssh/$(hostname).pub
   cat ~/.ssh/ggrangel-git-signing.pub
   ```
   Copy outputs and add to GitHub authentication and signing keys.

5. **Switch to SSH remote**
   ```bash
   cd /etc/nixos
   sudo git remote set-url origin git@github.com:ggrangel/nixos.git
   ```

6. **Clone dotfiles**
   ```bash
   git clone git@github.com:ggrangel/dotfiles.git ~/.config
   ```

7. **Reboot**
   ```bash
   sudo reboot
   ```

**Notes**:
- To push changes from /etc/nixos, use `sudo -E git push` (the -E flag preserves the SSH agent that the sudo user doesn't have access to)
