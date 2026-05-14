# Alpine Installation and Minimal Configuration

## Install process
Downloaded the extanded ISO (includes more packages), which is safer, but likely not needed.
Used `setup-alpine` script, which works well.
Need to be aware of WiFi being very picky, may need a re-try.
And there is no easy way to avoid swap, just use 'sys' for disk mode, remove swap later if needed.
I picked chrony for NTP, but using BusyBox (already present) is probably a better idea.
Keep SSH default, useful for git later.
I started with `ash` the default shell. Used `doas` which is the default, but later added `doas-sudo-shim` to use `sudo` as a wrapper.

## Install packages

### Package Manager: apk
The `apk` package manager is quite good for a fast and minimal one. It may be a bit rough at first.
Installing and removing is simple, but other functions are not so obvious. There is no `tldr` package, have to install `man-db` and use that.
The community repo is worth enabling right away, it's in `/etc/apk/repositories` file, just uncomment the line.

Useful commands:
```bash
apk search <pkg>    # search the repositories
apk add <pkg>		# install a package or a list; list has to be explicit
apk del <pkg>		# remove  a package or a list; list has to be explicit
apk info <pkg>		# description of a package, web link, package size

apk list --installed | grep <pkg>	# a clean way to check if a package is installed
apk list | grep <pkg>				# shows the version and the short {name}

apk update			# refresh the repos
apk upgrade			# update all packages

```

The packages in Alpine are stored in 2 ways: full and 'world'.

To get the full list:
```bash
sudo apk info >> pkglist-apk.txt
```

To get the 'world' list:
```bash
cp /etc/apk/world world-bkp.txt
```

The 'world' file is the list of packages that are explicitly installed.
That should likely be enough to reproduce the existing system in terms of installed packages.

## Configure services

### ufw
Same as Artix.

### eudev
eudev is a device manager that provides a drop-in replacement for systemd udev. It is a requirement for NetworkManager integration with iwd.

### Network
Here, I reproduced the NetworkManager + iwd that works really well for me.
Need to delete `wpa_supplicant` and `networking` from services, they will be replaced with `iwd` and `NetworkManager` respectively.
Initially, I had no `eudev` installed and running. It is still possible to get `iwd` working through `iwctl` just like in Arch ISO.
But here we need to separately obtain the IP address by running `udhcpc -i wlan0`. The interface is important, it may default to eth0 and fail.
Once the connection is established, install `nmcli` and `nmtui` along with the main `networkmanager` package. The names in apk may differ a bit.
Here, the most important step after the device manager was to configure the NetworkManager.

See `etc/NetworkManager/NetworkManager.conf`, the minimal sufficient file.

### D-Bus
D-Bus is a message bus system. It is a prerequisite for Polkit.

### Polkit
Polkit is an authentication manager. It is a prerequisite for elogind.

### elogind
elogind is extracted out of "logind" - systemd login manager to be standalone daemon, it is used in other OpenRC based distros, including Artix.
Go to  wiki.alpinelinux.org/wiki/Elogind  and follow the prerequisites to install the stack. The wiki is very clear.

### PAM
linux-pam may already be installed. It is required and needs to be wired. The missing link is that the `login` file is located in `/usr/lib/pam.d`,
while needed in `/etc/pam.d`. The file is backed up, but can be copied over and edited. The only missing line for the elogind stack is this:
```
session		optional	pam_elogind.so
```
NOTE: this is not documented anywhere. Maybe I hit this because I did not use the scripts.
When all of this is in place, after reboot, `loginctl` should show `seat0, tty1, etc...`. This is what we need for a graphical Wayland session.

## Known issues + lessons learned

### Important TODO!
Revice `fish_history.txt`, this has the history of how to get the elogind setup. It's likely simple, but needs to be extracted and documented!

### fish
After elogind is working and the session is real, it is possible to switch the shell permanently with chsh.
After switching, I observed that the PATH is not propagated. That is why using `ash`, the default shell (and maybe calling `fish`within) is safer.
The PATH resolution is added to fish config of this depot. All the packages are very minimal and broken down into components.
It looks like fish installation is not as full as on other distros, so it may be best to keep it minimal, at least for now.

NOTE:
Later discovery is that it's another packet fragmentation issue, which can be solved by installing `fish-tools` packet.
Once installed, prompts and themes are available, but the default theme is onee of the best. Chose to customize Kitty color pallette.

### Graphical test with Weston
The txt files contain all the necessary info. It was hard to figure out, but it's easy once the packages and commands are handy.
If Weston starts, there is no easy way to exit, you have to pkill it from another tty.
Once Wayland is confirmed working, remove the packages (deps are taken care of).

### Black screen issue
After elogind stack was working, I encountered a black screen issue. Could not recover, had to hard power off.
The suspect is the power management (DPMS) integration via elogind.
The config file `/etc/elogind/logind.conf` was modified to attempt to remedy this with explicit `ignore` settings.
The file is backed up here. The issue did not reappear up until and during the writing of this.

### Git repo
A new Git repo must be created in the web interface first. After that the instructions there (git website) and in the Artix repo apply.
Watch out for username or remote address typos.
Watch out for ` 1 vs l vs I ` in the generated key. If at least one character is wrong, it will error out as an invalid key.
