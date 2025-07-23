#!/usr/bin/env bash

# Hyprland Rice Installer

set -euo pipefail

################
#### Colors ####
################
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NONE=$(tput sgr0)

####################
#### Root Check ####
####################
if [[$EUID -eq 0]]; then
  echo -e "${RED}ERROR: Do not run this script as root!${NONE}"
  exit 1
fi

######################
#### Confirmation ####
######################
echo -e "${YELLOW}This script will:"
echo "- Update system packages"
echo "- Remove existing configs (~/.config/hypr, ~/.config/quickshell, ~/.config/nvim)"
echo "- Install Hyprland-git, hypridle, hyprlock, quickshell-git, and Neovim${NC}"
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    echo -e "${RED}Aborted.${NONE}"
    exit 1
fi

#################
#### Phase 1 ####
#################
echo -e "${GREEN}[1/4] Updating system...${NONE}"
sudo pacman -Syu --noconfirm || {
    echo -e "${RED}Failed to update system${NONE}"
    exit 1
}
