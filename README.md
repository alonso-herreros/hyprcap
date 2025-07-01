# HyprCap

[![AUR version][aur-shield]][aur-link]
[![AUR git version][aur-git-shield]][aur-git-link]
[![Latest GitHub release][release-shield]][release-link]

HyprCap is a utility to easily capture screenshots and screen recordings on
[Hyprland](https://hyprland.org/).

It allows selecting windows, regions and monitors with your mouse, or with
command line arguments.

<!-- It allows selecting windows, regions and monitors with your mouse, a -->
<!-- `dmenu`-like program, or with command line arguments. -->

## Installation

### Arch Linux

This utility is available in the [AUR](https://aur.archlinux.org/packages/hyprcap). You can install it
using an AUR helper like `yay`:

```bash
yay -S hyprcap
```

### Manual installation

#### Dependencies

Install the required dependencies using your package manager. For example, on
Arch Linux, you can use:

```bash
sudo pacman -S wf-recorder grim slurp hyprland jq wl-clipboard hyprpicker libnotify
```

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

#### Copy the script

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

# Screenshot a region
bind = $MOD SHIFT, S,     exec, hyprcap shot region -z -c -n
# Screenshot current window
bind = $MOD SHIFT ALT, S, exec, hyprcap shot window:active -z -c -n

# Toggle recording a region
bind = $MOD SHIFT, R,     exec, hyprcap rec region -c -n
# Toggle recording current window
bind = $MOD SHIFT ALT, R, exec, hyprcap rec window:active -c -n
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

[aur-shield]: https://img.shields.io/aur/version/hyprcap?label=hyprcap&logo=arch+linux
[aur-link]: https://aur.archlinux.org/packages/hyprcap
[aur-git-shield]: https://img.shields.io/aur/version/hyprcap-git?label=hyprcap-git&logo=arch+linux
[aur-git-link]: https://aur.archlinux.org/packages/hyprcap-git
[release-shield]: https://img.shields.io/github/v/release/alonso-herreros/hyprcap?color=green&logo=github
[release-link]: https://github.com/alonso-herreros/hyprcap/releases/latest
