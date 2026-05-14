#!/bin/sh
# Set a random wallpaper from ~/Pictures/wallpapers using swww

WALLDIR="$HOME/Pictures/wallpapers"

# pick a random regular file (handles newlines and spaces)
file="$(find "$WALLDIR" -maxdepth 1 -type f -print0 | shuf -z -n 1 | xargs -0 -I{} printf '%s\n' "{}")"

[ -z "$file" ] && {
  printf 'No wallpapers found in %s\n' "$WALLDIR" >&2
  exit 1
}

swww img "$file" --transition-type fade --transition-duration 5
