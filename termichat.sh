#!/bin/bash

# ==============================================================================
# Project: Bash Terminal Chat Application
# System: Garuda Linux / Arch Linux
# Dependency: ncat (from nmap package)
# ==============================================================================

# --- Colors for UI ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- Dependency Check ---
if ! command -v ncat &> /dev/null; then
    echo -e "${RED}[Error] 'ncat' is not installed.${NC}"
    echo "This script requires ncat (with broker mode)."
    echo -e "Please install it on Garuda/Arch using: ${GREEN}sudo pacman -S nmap${NC}"
    exit 1
fi

clear
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}   TERMINAL CHAT SYSTEM (BASH)          ${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo "Select Mode:"
echo "1) Server (Host the Chat Room)"
echo "2) Client (Join a Chat Room)"
echo ""
read -p "Enter choice [1 or 2]: " choice

# ==============================================================================
# SERVER LOGIC
# ==============================================================================
if [[ "$choice" == "1" ]]; then
    echo ""
    echo -e "${GREEN}--- STARTING SERVER ---${NC}"

    # Get local IP for convenience
    local_ip=$(hostname -I | awk '{print $1}')

    read -p "Enter Port to listen on (default 12345): " PORT
    PORT=${PORT:-12345}

    echo -e "Server listening on IP: ${BLUE}$local_ip${NC}"
    echo -e "Server listening on Port: ${BLUE}$PORT${NC}"
    echo "Waiting for clients to connect..."
    echo "Press [Ctrl+C] to stop the server."

    # Run ncat in BROKER mode.
    # -l: listen
    # -p: port
    # --broker: enables multi-user chat hub
    # -v: verbose (to see who connects)
    ncat -l -p "$PORT" --broker -v

# ==============================================================================
# CLIENT LOGIC
# ==============================================================================
elif [[ "$choice" == "2" ]]; then
    echo ""
    echo -e "${GREEN}--- JOINING CHAT ---${NC}"

    read -p "Enter Server IP: " SERVER_IP
    read -p "Enter Server Port (default 12345): " PORT
    PORT=${PORT:-12345}
    read -p "Enter your Username: " USERNAME

    if [[ -z "$SERVER_IP" ]]; then
        echo -e "${RED}Error: IP Address is required.${NC}"
        exit 1
    fi

    clear
    echo -e "${CYAN}Connected to chat as [${USERNAME}]${NC}"
    echo -e "Type a message and press Enter to send."
    echo -e "Press [Ctrl+C] to exit."
    echo "------------------------------------------------"

    # Input Loop:
    # We use a background process pipe to format messages before sending them to ncat.
    # This ensures every message you send is prefixed with your Username.

    (
        # Send an initial join message
        echo -e "${GREEN}>> $USERNAME has joined the chat.${NC}"

        # Loop to read user input
        while IFS= read -r line; do
            # Get current timestamp
            timestamp=$(date +"%H:%M")
            # Format: [Time] [User]: Message
            echo "[$timestamp] [$USERNAME]: $line"
        done
    ) | ncat "$SERVER_IP" "$PORT"

else
    echo "Invalid choice. Exiting."
    exit 1
fi
