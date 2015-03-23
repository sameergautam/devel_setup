#!/bin/bash

if [ ! -d "$HOME/.devel_setup" ]; then
    echo "Setting up your devel machine"
    git clone -q https://github.com/sameergautam/devel_setup.git "$HOME/.devel_setup"
    cd "$HOME/.devel_setup"
    LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 rake install
else
    echo "Hmmm... Already setup, eh!"
fi
