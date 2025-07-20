#!/bin/bash

# Enterprise Development Environment Setup
# Version: 1.0.0
# Author: Tia Astor
# License: MIT
# Description: Enterprise-grade development environment setup for Mac, Windows (WSL2), and Linux

set -e
set -o pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration Variables
NODE_VERSION="20.x"
PYTHON_VERSION="3.11"
GO_VERSION="1.21"
RUST_VERSION="stable"

# Logging setup
LOG_DIR="$HOME/.tiation/logs"
LOG_FILE="$LOG_DIR/install_$(date +%Y%m%d_%H%M%S).log"

# Function to detect OS
detect_os() {
    case "$(uname -s)" in
        Darwin*)    echo "macos" ;;
        Linux*)     
            if grep -q Microsoft /proc/version; then
                echo "wsl"
            else
                echo "linux"
            fi
            ;;
        CYGWIN*|MINGW*) echo "windows" ;;
        *)          echo "unknown" ;;
    esac
}

# Function to setup logging
setup_logging() {
    mkdir -p "$LOG_DIR"
    touch "$LOG_FILE"
    exec 3>&1 4>&2
    trap 'exec 1>&3 2>&4' 0 1 2 3
    exec 1> >(tee -a "$LOG_FILE") 2>&1
}

# Function to log messages
log() {
    local level=$1
    shift
    local message=$*
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    case "$level" in
        "INFO")     echo -e "${GREEN}[INFO]${NC} ${timestamp} - $message" ;;
        "WARN")     echo -e "${YELLOW}[WARN]${NC} ${timestamp} - $message" ;;
        "ERROR")    echo -e "${RED}[ERROR]${NC} ${timestamp} - $message" ;;
        *)          echo -e "${BLUE}[DEBUG]${NC} ${timestamp} - $message" ;;
    esac
}

# Function to check system requirements
check_requirements() {
    log "INFO" "Checking system requirements..."
    
    # Check for minimum RAM (8GB)
    local total_ram=$(grep MemTotal /proc/meminfo 2>/dev/null | awk '{print $2}' || sysctl -n hw.memsize 2>/dev/null)
    if [[ $total_ram -lt 8000000 ]]; then
        log "WARN" "Less than 8GB RAM detected. Some development tools may run slowly."
    fi

    # Check for disk space (minimum 20GB free)
    local free_space=$(df -k . | awk 'NR==2 {print $4}')
    if [[ $free_space -lt 20000000 ]]; then
        log "ERROR" "Insufficient disk space. At least 20GB free space required."
        exit 1
    fi
}

# Function to install base development tools
install_base_tools() {
    log "INFO" "Installing base development tools..."
    
    local os=$(detect_os)
    case "$os" in
        "macos")
            # Install Homebrew if not present
            if ! command -v brew >/dev/null 2>&1; then
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install git curl wget jq
            ;;
        "linux"|"wsl")
            sudo apt-get update
            sudo apt-get install -y build-essential git curl wget jq
            ;;
    esac
}

# Function to setup Node.js environment
setup_node() {
    log "INFO" "Setting up Node.js environment..."
    
    local os=$(detect_os)
    case "$os" in
        "macos")
            brew install node
            ;;
        "linux"|"wsl")
            curl -fsSL "https://deb.nodesource.com/setup_${NODE_VERSION}" | sudo -E bash -
            sudo apt-get install -y nodejs
            ;;
    esac

    # Install global npm packages
    npm install -g yarn typescript pm2
}

# Function to setup Python environment
setup_python() {
    log "INFO" "Setting up Python environment..."
    
    local os=$(detect_os)
    case "$os" in
        "macos")
            brew install python@$PYTHON_VERSION
            ;;
        "linux"|"wsl")
            sudo apt-get install -y python3 python3-pip python3-venv
            ;;
    esac

    # Setup pip and virtual environment
    python3 -m pip install --upgrade pip
    python3 -m pip install virtualenv poetry
}

# Main execution
main() {
    log "INFO" "Starting enterprise development environment setup..."
    
    setup_logging
    check_requirements
    
    # Install components based on detected OS
    local os=$(detect_os)
    log "INFO" "Detected OS: $os"
    
    install_base_tools
    setup_node
    setup_python
    
    log "INFO" "Setup completed successfully!"
    log "INFO" "Log file location: $LOG_FILE"
}

# Execute main function
main "$@"
