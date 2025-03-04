# ian_mcbee-dotfiles
## Instructions
### Option 1 - Copy and Paste
Copy and paste what you want to use and make sure that you have the corresponding applications.

### Option 2 - GNU Stow
1. Use the `Brew file` to get all casks/taps/formulae. GNU Stow should be in that list.
2. Clone down dotfiles repo in `~`
3. Back up existing `.zshrc` and other configurations and `.config` settings.
4. Make sure the folder structure in dotfiles mirrors in your root directory. (i.e. dotfiles/.config/ghostty => ~/.config/ghostty)
5. Make sure any files/directories do not interfere with your current files/directories!
6. At dotfiles repo directory, run `stow --adopt .` . If you choose to only adopt specific files, change the `.` to specific files.
7. Make sure the files in the dotfile repo have symlinks in the correct locations. How I check to see if there are symlinks in the proper place is opening vscode in root directory and check all places to see if symlink files are present.  There is probably a better way.

Hope that helps, let me know if you run into trouble or have suggestions.

Outdated: 02/26/25
---

Hey! This is a copy of my dotfiles and it is a mess, especially my nvim settings and plugins.  I am trying to update my nvim settings to be more useable for work, but that will take some time. If you know more, hit me up on slack! I am sharing this dotfile iteration because some people in the Arlington, VA office were interested and it was suggested to share on the #slackoverflow channel. Below is the list of apps and settings that I use, I can provide more detail later or in a DM if you message me.

- kitty terminal: I use kitty term and I have the settings in my config directory
- fzf: I have a settings file
- ghostty terminal: the settings match kitty, but I don't use it since it is still infant, but definitely better than iterm.
- fastfetch: like neofetch and I have a settings for mac
- nvim: it needs an update with recent updates to lazyvim, which is the distro I currently use
- *ignore* my raycast stuff, I am having symlink issues and got to figure it out and it is end of day
- stow: I use stow for dotfiles, I don't have time for NixOS
- obsidian: i just have my style settings on there

There are probably other things there, but I will update this README once I get some time.

Enjoy!
