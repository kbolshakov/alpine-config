# Niri installation

## List of packages

This is a final, complete list with extras. Original sequence is in `apk_history_niri.txt` file, just in case.

```bash
# base
wayland-libs-server
wayland-libs-client
wayland-libs-egl
mesa-egl
mesa-gl
wayland-utils
xwayland
niri
xdg-desktop-portal
xdg-desktop-portal-gtk
xdg-desktop-portal-openrc
waybar
wofi
mako
mako-fish-completion
foot
kitty
kitty-kitten
kitty-terminfo
kitty-wayland
mousepad

# audio (preliminary)
pipewire
pipewire-pulse
pipewire-alsa
pipewire-openrc
pipewire-pulse-openrc
wireplumber
wireplumber-openrc
wireplumber-logind

# utils
wl-clipboard
wl-clipboard-fish-completion
brightnessctl
brightnessctl-openrc
playerctl
thunar
thunar-volman
file-roller
imv
imv-wayland
firefox

# fonts, icons, cursor (starter)
font-inter
font-fira-mono-nerd
papirus-icon-theme
numix-icon-theme
capitaine-cursors

# wallpaper
swww
swww-fish-completion
```

## Solved NoWaylandLib
(what's that?)

## Starting from tty
Turns out there is a slightly different way to start Niri in Alpine.
There is no `niri-session`, which may be newer or older than the current package.
What worked (but without audio for now):
```bash
dbus-run-session niri --session
```
Once things are stabilized, this can be used right after the login.

## Config
This is a list of main configuration areas, which are now all in `~/.config/niri/config.kdl`:
- gaps
- rounded corners
- focus ring
- animations
- startup apps
- keybinds
- layer rules
- cursor settings (Niri native)

Eventually installed `Bibata-Modern-Classic` and `Bibata-Modern-Ice` with preference for latter. It looks ridiculously good on a dark theme.
Download both from KDE or Gnome (same thing):
	[Bibata-Modern-Classic](https://www.gnome-look.org/p/1914825/ "Classic")
	[Bibata-Modern-Ice](https://www.gnome-look.org/p/1197198/ "Ice")
	
## Wallpaper
Chose `swww`, added `spawn-sh-at-startup "swww-daemon &"` and the fade-in load by default.
The same 'fade' transition is done in `~/Pictures/wallpapers/reload_random.sh` script.
All the pictures are downloaded in *2K* from [Bing Wallpaper Archive](https://bingwallpaper.anerg.com/).
The default one is set to [AlabamaHills](https://bingwallpaper.anerg.com/detail/us/AlabamaHills)

## Wofi
Not much configuration so far, except fixing rounded corners with CSS background matching.
Stole the theme from tonybtw, and added a mild shadow.

## Terminal
Kept 2 terminals: `foot` as a simple, reliable fallback, `kitty` as the primary feature-rich one.
Kitty was missing `kitty-kitten`, which is a separate package in Alpine.

Configured in Kitty to my taste:
- Theme (Tokyo Night)
- Opacity (0.9)
- Cursor shape/blink (shell integration workaround)
- Visual tuning (corners and margins)

## Waybar

I'd say it's still incomplete, but it can be a *real time-sink*. For a true minimal system, this is already plenty.

Configured:
- workspace display
- taskbar (window list)
- active window
- clock/calendar
- CPU/RAM display
- language indicator
- styling/theme integration

## GTK theming

There is nothing there yet, but the inportant part to theme GTK apps to be dark.
The config file should be here: `~/.config/gtk-3.0/settings.ini` (apparently).






