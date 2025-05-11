#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install Git
echo "Installing Git..."
sudo apt install -y git

# Install dependencies
sudo apt install -y curl wget gnupg2 ca-certificates lsb-release software-properties-common apt-transport-https

# Install VS Code
echo "Installing VS Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm microsoft.gpg

# Install Postman (via Snap)
echo "Installing Postman..."
sudo snap install postman

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
rm get-docker.sh

# Install Docker Compose (v2 plugin)
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION="v2.27.0"
mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m) -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

# Install NVM
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js (optional: latest LTS)
nvm install --lts

# Install Zsh
echo "Installing Zsh..."
sudo apt install -y zsh
chsh -s $(which zsh)

# Optional: Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installation complete. You may need to restart your terminal or log out and back in."

echo "Installing Warp Terminal..."
WARP_VERSION=$(curl -s https://api.warp.dev/latest/linux | grep -oP 'https://.*?\.deb')
wget "$WARP_VERSION" -O warp.deb
sudo apt install -y ./warp.deb
rm warp.deb

# Install IBus Bamboo for Vietnamese typing
echo "Installing IBus Bamboo for Vietnamese input..."
sudo add-apt-repository -y ppa:bamboo-engine/ibus-bamboo
sudo apt update
sudo apt install -y ibus ibus-bamboo
ibus restart
