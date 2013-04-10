#! bin/bash

if [ -h ~/.bashrc ]; then
        echo "unlinking .bashrc file"
        unlink ~/.bashrc
else    
        echo "removing sourcing line from existing bashrc file"
        sed '/dotfiles/d' ~/.bashrc > ~/.bashrc
fi

if [ -h ~/.bash_profile ]; then
        echo "unlinking .bash_profile file"
        unlink ~/.bash_profile
else
        echo "removing sourcing line from existing bash_profile file"
        sed '/dotfiles/d' ~/.bash_profile > ~/.bash_profile
fi

if [ -h ~/.vimrc ]; then
        echo "unlinking .vimrc file"
        unlink ~/.vimrc
else
        echo "check the existing .vimrc file"
fi

if [ -h ~/.vim ]; then
        echo "unlinking .vim folder"
        unlink ~/.vim
else
        echo "check the existing .vim folder"
fi

if [ -h ~/.gitconfig ]; then
        echo "unlinking .gitconfig folder"
        unlink ~/.gitconfig
else
        echo "check the existing .gitconfig file"
fi

echo "All Done"
