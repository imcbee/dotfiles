```
_________/\\\_____________________________________/\\\\\________/\\\\\\________________________________        
 ________\/\\\___________________________________/\\\///________\////\\\________________________________       
  ________\/\\\____________________/\\\__________/\\\_______/\\\____\/\\\________________________________      
   ________\/\\\______/\\\\\_____/\\\\\\\\\\\__/\\\\\\\\\___\///_____\/\\\________/\\\\\\\\___/\\\\\\\\\\_     
    ___/\\\\\\\\\____/\\\///\\\__\////\\\////__\////\\\//_____/\\\____\/\\\______/\\\/////\\\_\/\\\//////__    
     __/\\\////\\\___/\\\__\//\\\____\/\\\_________\/\\\______\/\\\____\/\\\_____/\\\\\\\\\\\__\/\\\\\\\\\\_   
      _\/\\\__\/\\\__\//\\\__/\\\_____\/\\\_/\\_____\/\\\______\/\\\____\/\\\____\//\\///////___\////////\\\_  
       _\//\\\\\\\/\\__\///\\\\\/______\//\\\\\______\/\\\______\/\\\__/\\\\\\\\\__\//\\\\\\\\\\__/\\\\\\\\\\_ 
        __\///////\//_____\/////_________\/////_______\///_______\///__\/////////____\//////////__\//////////__
```

# dotfiles

Hey! This is my `dotfiles` repository.

## Table of Contents
* [1. Description](#1-description)
* [2. Setup from a blank slate](#2-core-configuration)
* [3. Take what you need](#3-take-what-you-need)
* [4. Conclusion](#4-conclusion)

## 1. Description

A "dotfiles" repository is basically a git repository where you can have you zsh configurations and any other applications or software configurations backed up and version controlled. How do you edit and manage your configurations in one repository when your configurations live across multiply directories? [GNU Stow](https://www.gnu.org/software/stow/) helps each file to be symlinked from the repository to it's right place to work. And you can edit these files in your dotfiles git repository and those changes will show up in your configurations.

To get a better understanding or have some visuals on how GNU Stow works, I used this [youtube video](https://www.youtube.com/watch?v=y6XCebnB9gs) to help me set up my dotfiles.

How this repository is setup structurally is each configuration is broken up in pieces and stored in each directory. For example, all of my kitty terminal settings live in the "kitty" directory. My zsh related settings like my `.zshrc` or my terminal prompt live in the "zsh" directory.

> [!IMPORTANT]
> This setup is more mac or linux machines only. In windows, I usually just copy and paste what I need like my `starship.toml` file.

## 2. Setup from a blank slate

If you have a fresh mac...

1. Get a coffee
2. Run `./setup.sh` (this will take awhile)
3. Take a walk with your coffee

This will take awhile since the script will download [homebrew](https://brew.sh/), load the `Brewfile` and run other set up configuration that I use at work daily. See the setup script for more details.

## 3. Take what you need

If you just want one or multiple packages without having to run the `setup.sh` script, you can use the command below:

```bash
# This is the format:
# stow -v -R -t <home directory> <directory you want i.e. "ghostty">

# What you will run in your terminal if you want 1 packages
stow -v -R -t ~ ghostty

# What you will run in your terminal if you want multiple packages
stow -v -R -t ~ ghostty nvim starship
```

If you just want a single file, it would probably be easier to copy and paste the file in your own dotfiles repository and run a `stow -v -R -t ~ <folder with config(s)>`

> [!IMPORTANT]
> If you look at the folder structure in each package like ghostty, the path is `~/.config/ghostty/config`. You must structure each package to match the folder structure on your system with where your `config` file will live.

## 4. Conclusion

That's about it. Feel free to ask me questions and I will do my best to respond. Feel free to fork this repository and I will always take suggestions, but I will not accept PRs. Thanks!
