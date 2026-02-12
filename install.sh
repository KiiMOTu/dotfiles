#!/bin/bash
set -e

echo "Installing zsh and dependencies..."
sudo apt install -y zsh git curl

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y


echo "Applying config..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/.zshrc" ~/.zshrc
cp "$SCRIPT_DIR/.nanorc" ~/.nanorc

echo "Setting zsh as default shell..."
chsh -s $(which zsh)

echo "Setting nano as default text editor..."
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nano 100
sudo update-alternatives --set editor /usr/bin/nano


echo "Done! Restart your shell or run: exec zsh"
