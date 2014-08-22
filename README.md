Jonathan (Jonny) Johannes' Dotfiles
===================================
  
  These are the ever-evolving configurations I use to make the terminal feel like home. 

  The systems I use are my Mac and a number of Linux systems including the [WestGrid](http://westgrid.ca/) computers.

Overview
--------

  These dotfiles provide a pretty simple and standard setup:
  
  - bash: aliases, configuration, environment settings
  - vim: syntax highlighting, colour theme, etc
  - git: config file, autocomplete
  - rvmrc (ruby) and virtualenv (python): the dotfiles will source these if they are present and installed already

Installation
------------
    
    git clone git://github.com/jonnyjohannes/dotfiles.git ~/.dotfiles
    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/vimrc ~/.vimrc
    ln -s ~/.dotfiles/zshrc ~/.zshrc
    ln -s ~/.dotfiles/bashrc ~/.bashrc
    ln -s ~/.dotfiles/bashrc ~/.bash_profile
    ln -s ~/.dotfiles/gitconfig ~/.gitconfig

Uninstall
---------

  remove symlinks 

