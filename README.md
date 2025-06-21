# HyprCap

HyprCap is a utility to easily capture screenshots and screen recordings on
[Hyprland](https://hyprland.org/).

It allows selecting windows, regions and monitors with your mouse, or with
command line arguments.

<!-- It allows selecting windows, regions and monitors with your mouse, a -->
<!-- `dmenu`-like program, or with command line arguments. -->

> [!WARNING]
>
> This project is in early development.  You can report issues on the [GitHub
> repository](https://alonso-herreros/hyprcap/issues).

## Installation

Only manual installation is possible at the moment.

### Dependencies

The following dependencies are **required** to run HyprCap:

- `wf-recorder`
- `grim`
- `slurp`
- `hyprland`
- `jq`

The following extras are not essential, but required for some features

- `wl-clipboard` to copy to clipboard
- `hyprpicker` to freeze the screen
- `libnotify` + a notification daemon to get notified
<!-- - dmenu or equivalent (to use an interactive menu) -->

### Manual installation

Copy the `hyprcap` script to a folder in your `PATH`:

```bash
git clone https://alonso-herreros/hyprcap.git HyprCap
cp HyprCap/hyprcap /usr/local/bin
```

For user-level installation, you can use:

```bash
git clone https://alonso-herreros/hyprcap.git HyprCap
cp HyprCap/hyprcap $HOME/.local/bin
```

You're free to delete the cloned repository after copying the script.

## Usage

You can get help on how to use HyprCap by executing:

```bash
hyprcap -h
```

The simplest usage of HyprCap is executing it with one of the available modes.

For example, to capture the currently focused window as a screenshot:

```bash
hyprcap shot window:active
```

## Configuration

You can add the various modes as keybindings in your Hyprland config like so:

```ini
# ~/.config/hypr/hyprland.conf

...

# Capture a region
bind = $MOD SHFIT, R, exec, hyprcap shot region
# Capture current window
bind = $MOD SHIFT ALT, R, exec, hyprcap shot window:active
# Open interactive capture menu (not yet implemented)
# bind = $MOD SHIFT CTRL, R, exec, hyprcap
```

### Save location

You can save the captures by using the `--write` option. The `--out-dir` and
`--filename` options can be used to specify the output directory and filename

## Contributing

Contributions are welcome! You can help by:

- Reporting bugs and issues on the [GitHub
  repository](https://alonso-herreros/hyprcap/issues)
- Suggesting new features or improvements
- Submitting pull requests with fixes or new features
- Improving the documentation
- Testing the utility and providing feedback

## Credit

This project is based on [Gustash's
Hyprshot](https://github.com/Gustash/Hyprshot)
