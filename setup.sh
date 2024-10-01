#!/bin/zsh

# Function to install packages on Ubuntu
install_ubuntu() {
    sudo apt update
    sudo apt install -y docker.io kubectl terraform google-cloud-sdk
    install_kind
    install_rye
}

# Function to install packages on Fedora
install_fedora() {
    sudo dnf install -y docker kubectl terraform google-cloud-sdk
    install_kind
    install_rye
}

# Function to install packages on Arch Linux
install_arch() {
    sudo pacman -Syu --noconfirm docker kubectl terraform google-cloud-sdk
    install_kind
    install_rye
}

# Function to install kind
install_kind() {
    ARCH=$(uname -m)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [[ "$ARCH" == "arm64" ]]; then
            curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-arm64
        else
            curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-amd64
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [[ "$ARCH" == "aarch64" ]]; then
            curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-arm64
        else
            curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
        fi
    elif [[ "$OSTYPE" == "msys" ]]; then
        curl -Lo ./kind.exe https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64
        mv ./kind.exe /usr/local/bin/kind.exe
        return
    fi
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
}

# Function to install Rye
install_rye() {
    ARCH=$(uname -m)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [[ "$ARCH" == "arm64" ]]; then
            curl -Lo ./rye https://github.com/astral-sh/rye/releases/latest/download/rye-aarch64-macos.gz
        else
            curl -Lo ./rye https://github.com/astral-sh/rye/releases/latest/download/rye-x86_64-macos.gz
        fi
        gunzip ./rye
        chmod +x ./rye
        sudo mv ./rye /usr/local/bin/rye
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -sSf https://rye.astral.sh/get | bash
    elif [[ "$OSTYPE" == "msys" ]]; then
        curl -Lo ./rye.exe https://github.com/astral-sh/rye/releases/latest/download/rye-x86_64-windows.exe
        mv ./rye.exe /usr/local/bin/rye.exe
    fi
}
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
        install_ubuntu
    elif command -v dnf &> /dev/null; then
        install_fedora
    elif command -v pacman &> /dev/null; then
        install_arch
    else
        echo "Unsupported Linux distribution"
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install docker kubectl terraform google-cloud-sdk
    install_kind
elif [[ "$OSTYPE" == "msys" ]]; then
    choco install docker-desktop kubernetes-cli terraform google-cloud-sdk
    install_kind
else
    echo "Unsupported OS"
    exit 1
fi

# Start Docker service on Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# Installing python dependencies
rye sync

echo "Setup complete. Docker, kind, kubectl, gcloud, and terraform are installed."
