#!/bin/sh

echo "Installing command-line tools...";
# xcode-select --install;
echo "Installed command-line tools!\n";

echo "Installing Oh-my-zsh...";
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
echo "Installed Oh-my-zsh!\n";
sleep 1;

echo "Installing Homebrew...";
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
echo "Installed Homebrew!\n";
sleep 1;

echo "Installing asdf package manager...";
# brew install asdf;
echo "Installed asdf!\n";
sleep 1;

echo "Installing docker...";
# brew install docker docker-compose docker-credential-helper
docker version;
echo "\n"
sleep 1;

echo "Installing colima...";
# brew install colima
colima version;
echo "\n"

# echo "Installing maccy, shottr...";
# brew install --cask maccy shottr notion
sleep 1

echo "setting up base Git directory (e.g. personal)..."
mkdir -p $HOME/Git/prs
touch $HOME/Git/prs/.gitconfig

echo "[user]\n\temail=\"artursbmello@gmail.com\"\n\tname=Artur Mello\n[core]\n\tsshCommand=\"ssh -i ~/.ssh/personal_github_key\"" > $HOME/Git/prs/.gitconfig

echo "setting up SSH key for github account (e.g. personal: ~/.ssh/personal_github_key)...\n"
ssh-keygen -t ed25519 -C "artursbmello@gmail.com"

pbcopy $HOME/.ssh/personal_github_key.pub
sleep 1

touch $HOME/.ssh/config
echo "Host my.github.com\n\tHostname github.com\n\tUser git\n\tIdentityFile ~/.ssh/personal_github_key\n\tUseKeychain yes" >> $HOME/.ssh/config









