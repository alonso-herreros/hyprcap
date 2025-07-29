# HyprCap

[![AUR version][aur-shield]][aur-link]
[![AUR git version][aur-git-shield]][aur-git-link]
[![Latest GitHub release][release-shield]][release-link]

HyprCap is a utility to easily capture screenshots and screen recordings on
[Hyprland](https://hyprland.org/).

It allows selecting windows, regions and monitors with your mouse, command line
arguments, or an interactive [`fuzzel`][fuzzel] menu.

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
- `fuzzel` to use an interactive menu
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

You can get help on how to use HyprCap by running `hyprcap -h`:

```
$ hyprcap -h
Usage: hyprcap [options...] <command> [[-s] <selection>]

HyprCap is a utility to easily capture screenshots and screen recordings on
Hyprland.

Please report bugs and issues at
https://github.com/alonso-herreros/hyprcap/issues

Commands:
  shot | screenshot            Take a screenshot
  rec | record                 Toggle screen recording
  rec-start | record-start     Start a screen recording
  rec-stop | record-stop       Stop a screen recording

A selection can be specified after the command, with the -m or --mode option,
or using a dmenu-like menu if neither is specified.

Selection:
  monitor                   Select an entire monitor interactively.
  monitor:active            Select the currently focused monitor.
  monitor:<name>            Select the monitor with the exact given name

  window                    Select a visible window interactively.
  window:active             Select the currently focused window.
  window:<title>            Select the first window that contains the title.

  region                    Select a region manually using 'slurp'.
  region:X,Y,WxH            Select the specified region.


Selection options:
  -s, --select <selection>      Alternative way to specify the selection.

Saving options:
  -w, --write                   Save the capture to a file using the default
                                filename and directory.
  -o, --output-dir <dir>        Directory in which to save captures.
                                Default: $XDG_PICTURES_DIR/Screenshots or
                                $XDG_VIDEOS_DIR/Captures
  -f, --filename <filename>     The file name for the resulting capture within
                                the output directory.
                                Default:
                                  YYYY-MM-DD-hhmmss_hyprcap.<extension>
                                where <extension> is determined by the command
                                (e.g. png for screenshots, mp4 for recordings).
  -F, --no-file                 Don't save captures to a file (default).
  -c, --copy                    Copy capture to clipboard with 'wl-copy'.

Capture options:
  -d, --delay <time>            How long to delay starting the capture after
                                selection is done in seconds.
  -z, --freeze                  Freeze the screen on initialization. Only
                                available for screenshots.

Notification options:
  -n, --notify                  Send a notification when capture is done.
                                (default).
  -N, --no-notify               Don't send notifications.
  -a, --actions                 Show actions in the notification (default).
                                Requires --notify.
  -A, --no-actions              Don't show actions in the notification. Requires
                                --notify.
  -t, --notif-timeout <time>    Notification timeout in milliseconds. Requires
                                --notify
                                Default: 10 seconds.

Output options:
  -r, --raw                     Output raw capture data to stdout.
  -v, --verbose                 Print extra information. Specify multiple times
                                to increase verbosity.
  -q, --quiet                   Print less information.
  -V, --version                 Show the version and exit.
  -h, --help                    Show this help message and exit.

Examples:
  Toggle recording current monitor      `hyprcap rec monitor:active`
  Screenshot a window (interactive)     `hyprcap shot window`
  Toggle recording a specific region    `hyprcap rec region:100,100,400x300`
  Stop an ongoing recording             `hyprcap rec-stop`
```

## Configuration

You can add the various modes as keybindings in your Hyprland config like so:

```ini
# ~/.config/hypr/hyprland.conf
# (from my dotfiles)

...

# Screenshot a region
bind = $MOD SHIFT, S,      exec, hyprcap shot region -z -c -n
# Screenshot current window
bind = $MOD SHIFT ALT, S,  exec, hyprcap shot window:active -z -c -n
# Screenshot with interactive selection
bind = $MOD SHIFT CTRL, S, exec, hyprcap shot -z -c -n

# Toggle recording a region
bind = $MOD SHIFT, R,      exec, hyprcap rec region -c -n
# Toggle recording current window
bind = $MOD SHIFT ALT, R,  exec, hyprcap rec window:active -c -n
# Toggle recording with interactive selection
bind = $MOD SHIFT CTRL, R, exec, hyprcap rec -c -n
```

### Save location

You can save the captures by using the `--write` option. The `--out-dir` and
`--filename` options can be used to specify the output directory and filename

## Contributing

Contributions are welcome! You can help by:

- Reporting bugs and issues on the [GitHub
  repository](https://github.com/alonso-herreros/hyprcap/issues)
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

[fuzzel]: https://codeberg.org/dnkl/fuzzel
