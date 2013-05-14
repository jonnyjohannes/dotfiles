#! bin/bash

echo "Working on .bashrc file"
if [ -f ~/.bashrc ]; then
        echo "source ~/.dotfiles/bashrc" > ~/.bashrc
else
        ln -s ~/.dotfiles/bashrc ~/.bashrc
fi

echo "Working on .bash_profile file"
if [ -f ~/.bash_profile ]; then
        echo "source ~/.dotfiles/bashrc" > ~/.bash_profile
else
        ln -s ~/.dotfiles/bashrc ~/.bash_profile
fi

echo "Working on .vimrc file"
if [ -f ~/.vimrc ]; then
        echo "A vimrc file already exists. Maybe check the contents before removing it and 'ln -s ~/.dotfiles/vimrc ~/.vimrc'"
else
        ln -s ~/.dotfiles/vimrc ~/.vimrc
fi

echo "Working on .vim folder"
if [ -f ~/.vim ]; then
        echo "A vim folder already exists. Maybe check the contents before removing it and 'ln -s ~/.dotfiles/vim ~/.vim'"
else
        ln -s ~/.dotfiles/vim ~/.vim
fi

echo "Working on .gitconfig file"
if [ -f ~/.gitconfig ]; then
        echo "A .gitconfig file already exists. Maybe check the contents before removing it and 'ln -s ~/.dotfiles/gitconfig ~/.gitconfig'"
else
        ln -s ~/.dotfiles/gitconfig ~/.gitconfig
fi

echo "All done"

