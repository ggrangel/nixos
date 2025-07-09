# NixOS server setup

1. **Clone NixOS config**
   ```bash
   git clone https://github.com/ggrangel/nixos.git /tmp/nixos
   sudo cp -r /tmp/nixos/* /etc/nixos/
   sudo nixos-rebuild switch
   ```

2. **Generate SSH key for GitHub**
   ```bash
   ssh-keygen -t ed25519 -C "gustavorangel91@gmail.com" -f ~/.ssh/<hostname>
   ssh-keygen -t ed25519 -C "gustavorangel91@gmail.com" -f ~/.ssh/ggrangel-git-signing
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/<hostname>
   ssh-add ~/.ssh/ggrangel-git-signing
   cat ~/.ssh/<hostname>.pub
   cat ~/.ssh/ggrangel-git-signing.pub
   ```

   Copy outputs and add to GitHub authentication and signing keys.

3. **Switch to SSH remote**
   ```bash
   cd /etc/nixos
   sudo git remote set-url origin git@github.com:ggrangel/nixos.git
   ```

4. **Clone dotfiles**
   ```bash
   git clone git@github.com:ggrangel/dotfiles.git ~/.config
   ```

5. **Apply home-manager config**
   ```bash
   home-manager switch
   ```

6. **Reboot**
   ```bash
   sudo reboot
   ```

**Notes**:
1. To push changes from /etc/nixos, use `sudo -E git push` (the -E flag preserves the SSH agent that the sudo user doesn't have access to)

