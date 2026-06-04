# Config Repo

This repo manages dotfiles deployed via GNU Stow.

## Workflow

- Edit files in `~/Documents/config/` (this repo)
- Stow creates symlinks from `$HOME` into the repo, so edits are live immediately
- Re-stow is only needed when new files are added that don't yet have symlinks:
  ```
  cd ~/Documents/config && stow --target=$HOME .
  ```
- Before stowing, remove any real files/directories at the target paths — stow will refuse to overwrite them
- If files are accidentally deleted from the working tree, restore with:
  ```
  git checkout HEAD -- <path>
  ```
