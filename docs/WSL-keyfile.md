# WSL Keyfile

## Overview

Currently, the main problem with running mwp using Windows 10 Subsystem for Linux (WSL) is that the settings / preferences cannot be saved (or easily changed) without overriding the defaults. This is inconvenient and error prone.

## Workaround

mwp has the capability to read (and write (e.g, from the preferences dialogue) settings to and from a "key file". This is a set of key / value pairs in the well known `.ini` format.

## mwp Usage

In order to use key file settings it is necessary to start mwp with the command line option `--use-keyfile-settings` , e.g.:

```
mwp --use-keyfile-settings
```

For convenience, this can be added to `cmdopts` default command line options file:

```
$ cat ~/.config/mwp/cmdopts
# use a key file for settings (WSL)
--use-keyfile-settings
```

On first run, mwp will save an (almost) empty settings file as `~/.config/mwp/mwp.ini`. The user can then add or amend settings using her favourite text editor. 

An example file might look like:

```
[mwp-wsl]
default-map='Bing Proxy'
default-zoom=18
font-fv=9
```

Note:

* the first line `[mwp-wsl]` is mandatory and should not be changed.
* the line `tote-float-p=true` is an internal setting managed by mwp, you are advised not to alter private keys ending in `-p`.
* The `font-fv` and `default-zoom` keys were added / edited by the user, the former to address font sizing differences between WSL and native usage.


## Postscript

Although this is intended to aid using mwp until WSL, it can also be used in Linux, through there is no good reason so to do.

Using a key file does not offer any of the type-safety / range of values checking that Linux tools like `dconf-editor` or `gsettings` provide.
