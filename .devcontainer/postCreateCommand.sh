#!/bin/bash

# this script runs first time when container is created
echo "running postCreateCommand.sh"

# store current pwd into a variable
current_pwd=$(pwd)
cd /usr/src/project

# Check if /usr/src/project/.git is a valid git repository
if [ -d "/usr/src/project/.git" ]; then
    # Set git to ignore file mode (permissions) changes in this repository
    git --git-dir=/usr/src/project/.git config core.fileMode false
else
    echo "Error: /usr/src/project/.git is not a valid git repository."
fi

# Set git to ignore file mode (permissions) changes globally for all repositories
git config --global core.fileMode false

echo "Enter your username:"
read username
case $username in
    afos)
        git config --global user.email "afos@dtu.dk"
        git config --global user.name "Anders Fosgerau"
        ;;
    jaholm)
        git config --global user.email "jaholm@dtu.dk"
        git config --global user.name "Jakob Holm"
        ;;
    vicre)
        git config --global user.email "vicre@dtu.dk"
        git config --global user.name "Victor Reipur"
        ;;
    vicmrp)
        git config --global user.email "victor.reipur@gmail.com"
        git config --global user.name "Victor Reipur"
        ;;
    *)
        echo "Enter your email:"
        read email
        git config --global user.email "$email"
        echo "Enter your name:"
        read name
        git config --global user.name "$name"
        ;;
esac

# git config --global --add safe.directory /usr/src/project
# git config --global --add safe.directory /mnt/project
# git config --global --add safe.directory /usr/src/project/.devcontainer/.docker-migrate
# git config --global --add safe.directory /usr/src/project/.devcontainer/.docker-image-builder
# git config pull.rebase true



# show current pip freeze
# echo "Show current pip freeze into requirements.txt..."
# echo "This is done so dependabot can taste the current environment."
# /usr/src/venvs/app-main/bin/pip freeze > /usr/src/project/app-main/requirements.txt

# This does not work because you rebuild the image often
# echo "Getting git submodules"
# git submodule init && git submodule update

# This does not work because you rebuild the image often
# git init initial commit
# echo "Initial commit"
# git add .
# git commit -m "Initial commit"

echo "Ending postCreateCommand.sh"

# restore the pwd
cd $current_pwd
