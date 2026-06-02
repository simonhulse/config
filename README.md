# config

Personal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

Clone the repo and run the install script:

```bash
git clone https://github.com/simonhulse/config.git ~/Documents/config
~/Documents/config/INSTALL
```

This installs stow (if not already present), creates symlinks for all config files into `$HOME`, and if running GNOME, loads the Gruvbox terminal profile via dconf.

## Maintenance

Once set up, the symlinks mean that any file edited (whether in `~/Documents/config` or at its target location in `$HOME`) is the same file. No sync step needed for edits.

If new files are added to the repo (e.g. after a `git pull`), re-run stow to create the missing symlinks:

```bash
stow --target="$HOME" --dir="$HOME/Documents/config" .
```

Stow is safe to re-run; it skips symlinks that already exist.

| Situation | Action |
|---|---|
| First time on a new machine | Run `INSTALL` |
| Pull changes to existing files | Nothing, symlinks are live |
| Pull and new files were added | Re-run `stow` |
| Edit a file locally | Nothing, changes are live in the repo |
