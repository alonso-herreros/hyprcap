# HyprCap

HyprCap is a utility to easily capture screenshots and screen recordings on
[Hyprland](https://hyprland.org/).

It allows selecting windows, regions and monitors with your mouse, a
`dmenu`-like program, or with command line arguments.

> [!WARNING] This project is in early development and may not work as expected.
> You can report issues on the [GitHub
> repository](https://alonso-herreros/hyprcap/issues).

## Installation

Only manual installation is possible at the moment.

### Dependencies

The following dependencies are required to run HyprCap:

- hyprland (`hyprctl` is used to interact with Hyprland)
- jq (to parse and manipulate json)
- dmenu or equivalent (to use an interactive menu)
- wf-recorder (to record the screen)
- grim (to take screenshots)
- slurp (to select a region)
- wl-clipboard (to copy to clipboard)
- libnotify (to get notified)

### Manual installation

Copy the `hyprcap` script to a folder in your `PATH`:

```bash
git clone https://alonso-herreros/hyprcap.git HyprCap
ln -s $(pwd)/HyprCap/hyprcap $HOME/.local/bin
```

## Usage

You can get help on how to use HyprCap by executing:

```bash
hyprcap -h
```

The simplest usage of HyprCap is executing it with one of the available modes.

For example, to capture the currently focused window as a screenshot:

```bash
hyprcap -m active-window
```

## Configuration

You can add the various modes as keybindings in your Hyprland config like so:

```ini
# ~/.config/hypr/hyprland.conf

...

# Capture a region
bind = $MOD SHFIT, R, exec, hyprcap -m region
# Capture a window
bind = $MOD SHIFT ALT, R, exec, hyprcap -m active -m window
# Open capture menu
bind = $MOD SHIFT CTRL, R, exec, hyprcap
```

### Save location

You can choose which directory HyprRe will save captures in by setting an
`HYPRCAP_DIR` environment variable to your preferred location.

If `HYPRCAP_DIR` is not set, HyprCap will attempt to save to `XDG_PICTURES_DIR`
and will further fallback to your home directory if this is also not available.

## Credit

This project is based on my fork of [Gustash's Hyprshot](https://github.com/Gustash/Hyprshot)
