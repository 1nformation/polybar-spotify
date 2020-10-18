# polybar-spotify

This polybar module shows details regarding the currently playing song on Spotify. The unique feature of this module is that the text displayed is constantly scrolled to save space on the bar. This is something that is not found in other spotify modules I came across. Also, this module uses [playerctl](https://github.com/altdesktop/playerctl) to do all the work and hence, no >100 line scripts which do all the work themselves. Only one line to fetch the required metadata in the format that you like and another line to scroll the fetched text using [zscroll](https://github.com/noctuid/zscroll).

![](screenshots/demo_mini.gif)
![](screenshots/demo.gif)

## Dependencies

- [playerctl](https://github.com/altdesktop/playerctl#installing) - To interface with Spotify
- [zscroll](https://github.com/noctuid/zscroll#installation) - To scroll the fetched text

## Polybar config

```ini
[module/spotify]
type = custom/script
format-offset = 10
tail = true
format = <label>
format-background = ${color.shade6}
format-foreground = ${color.modulefg}
exec = ~/.config/polybar/scroll_spotify_status.sh
```

The controls can be easily configured using the following modules. Again, make sure you have [playerctl](https://github.com/altdesktop/playerctl) installed.

```ini
[module/prev]
type = custom/ipc
hook-0 = echo ""
hook-1 = echo ""
format-offset = 10
format-background = ${color.shade6}
format-foreground = ${color.modulefg}
initial = 1
click-left = playerctl previous &

[module/pause]
type = custom/ipc
hook-0 = echo ""
hook-1 = echo ""
hook-2 = echo ""
format-background = ${color.shade6}
format-foreground = ${color.modulefg}
initial = 1
click-left = playerctl play-pause &

[module/next]
type = custom/ipc
hook-0 = echo ""
hook-1 = echo ""
format-background = ${color.shade6}
format-foreground = ${color.modulefg}
initial = 1
click-left = playerctl next &
```

NOTE: The above given play-pause module requires IPC support enabled for its parent bar. That can be done by adding `enable-ipc = true` in your bar config. Also make sure to replace `polybar main` in [get_spotify_status.sh](get_spotify_status.sh) with the command you are using to run polybar.

## Customization

- Since I'm using [playerctl](https://github.com/altdesktop/playerctl), this script will work with any of the players supported by it. For instance, VLC, Chromium, Audacious, etc. It can even be used with multiple players running simultaneously. More info [here](https://github.com/altdesktop/playerctl#selecting-players-to-control).
- The format of the fetched metadata can be changed in [get_spotify_status.sh](get_spotify_status.sh). This line needs to be changed
  ```sh
  playerctl metadata spotify --format "{{ title }} - {{ artist }}"
  ```
  More details on what attributes can be fetched can be found [here](https://github.com/altdesktop/playerctl/#printing-properties-and-metadata).
- The scrolling text can be configured in [scroll_spotify_status.sh](scroll_spotify_status.sh). 
  - The length can be configured using `-l` and delay using `-d`.
  - The separators between the infinitely scrolling text can be configured using `--before-text` and `--after-text` parameters.  
  More info about zscroll's parameters can be found in `man zscroll`.    

  ## Fonts

  This module uses Noto Sans Patched Nerd Font for glyphs.
  It can be downloaded from https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Noto/Sans/complete/Noto%20Sans%20Regular%20Nerd%20Font%20Complete.ttf

  Feel free to use any other fonts though

