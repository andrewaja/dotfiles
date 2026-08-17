# dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package whose internal path structure mirrors `$HOME` — running `stow <package>` from the repo root symlinks its contents into place.

## Structure

```
dotfiles/
  bash/                   # shell config
  nvim/.config/nvim/      # Neovim config (lazy.nvim-based)
  tmux/                   # tmux config
  script/                 # bootstrap and helper scripts
```

## Usage

Run `script/bootstrap` for first-time setup on a fresh machine.

### Note: WSL mirrored networking + ZeroTier MTU hang

**Symptom:** SSH from a WSL2 instance running in mirrored networking mode (`networkingMode=mirrored` in `.wslconfig`) hangs indefinitely at `SSH2_MSG_KEX_ECDH_REPLY`, after a clean TCP handshake and KEXINIT exchange. Ping over the same ZeroTier IP works fine; small packets pass, larger ones (like the key exchange payload) silently vanish.

**Cause:** ZeroTier's default interface MTU is 2800, above standard Ethernet's 1500. WSL2 mirrored-mode networking passes this oversized MTU through to the guest's mirrored interface without adjustment, and something on the path drops packets that exceed the effective safe size instead of fragmenting them.

**Fix:** Force the mirrored ZeroTier interface inside WSL down to a conservative MTU (1280, the IPv6 minimum) via a systemd oneshot service that waits for the interface to exist before setting it.

`wsl-zerotier-mtu/zerotier-mtu.service`:

```ini
[Unit]
Description=Set ZeroTier interface MTU
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'until ip link show eth2 >/dev/null 2>&1; do sleep 1; done; ip link set dev eth2 mtu 1280'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

**To deploy on a new WSL instance:**

```
sudo ln -sf ~/dotfiles/wsl-zerotier-mtu/zerotier-mtu.service /etc/systemd/system/zerotier-mtu.service
sudo systemctl enable zerotier-mtu.service
sudo systemctl start zerotier-mtu.service
```

**Notes:**
- `eth2` is hardcoded in the `ExecStart` line of `zerotier-mtu.service` (confirm this is correct)
- Requires `systemd=true` under `[boot]` in `/etc/wsl.conf`.

**My corresponding Windows-side WSL Config:**

`%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
networkingMode=mirrored
memory=24GB   # default is 50%
#processors=8  # default is all cores
swap=2GB

[experimental]
#sparseVhd=true # "Sparse VHD support is currently disabled due to potential data corruption."
autoMemoryReclaim=gradual
```
