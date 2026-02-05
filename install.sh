#!/bin/bash

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Iniciando Script de Instalación ===${NC}"

# Función para imprimir estado
status() {
  echo -e "${YELLOW}[*] $1...${NC}"
}

success() {
  echo -e "${GREEN}[OK] $1 completado.${NC}"
}

# 1. ACTUALIZACIÓN INICIAL
status "Actualizando repositorios y sistema"
sudo apt update && sudo apt upgrade -y
success "Sistema actualizado"

# 2. CORE
status "Instalando paquetes CORE"
sudo apt install -y build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl git \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
  liblzma-dev make gcc ripgrep fd-find unzip xclip python3-venv python3-pip npm pipx
success "Core instalado"

# 3. KVM / VIRTUALIZACIÓN
status "Configurando KVM y QEMU"
sudo apt install -y qemu-system libvirt-clients libvirt-daemon-system virt-manager
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $(whoami)
sudo usermod -aG kvm $(whoami)
success "KVM configurado (requiere reinicio para aplicar grupos)"

# 4. VSCODE
#status "Instalando Visual Studio Code"
#sudo apt install -y wget gpg
#wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
#sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
#echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
#rm packages.microsoft.gpg
#sudo apt update
#sudo apt install -y code
#success "VSCode instalado"

# 7. DROPBOX
status "Instalando Dropbox"
# Nota: Usamos el enlace proporcionado, pero ten en cuenta que las versiones cambian
wget -O dropbox.deb "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2024.04.17_amd64.deb"
sudo apt install -y ./dropbox.deb
rm dropbox.deb
success "Dropbox instalado"

# 5. OBSIDIAN (Método corregido: descarga directa del último .deb)
status "Instalando Obsidian (Última versión desde GitHub)"
OBSIDIAN_URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d : -f 2,3 | tr -d \")
wget -O obsidian.deb "$OBSIDIAN_URL"
sudo apt install -y ./obsidian.deb
rm obsidian.deb
success "Obsidian instalado"

# 6. ZOOM
status "Instalando Zoom"
wget -O zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb
success "Zoom instalado"

# 8. SURFSHARK
status "Instalando Surfshark VPN"
curl -f https://downloads.surfshark.com/linux/debian-install.sh --output surfshark-install.sh
sh surfshark-install.sh
rm surfshark-install.sh
success "Surfshark instalado (ejecuta 'sudo surfshark-vpn' manualmente al final)"

# --- SECCIÓN ENTORNOS PYTHON Y CLI ---

# Verificación de ZSH
if [ ! -f ~/.zshrc ]; then
  echo -e "${RED}[!] No se encontró .zshrc. Creando uno vacío para evitar errores.${NC}"
  touch ~/.zshrc
fi

# 9. PYENV
status "Instalando Pyenv"
if [ ! -d "$HOME/.pyenv" ]; then
  curl https://pyenv.run | bash
else
  echo "Pyenv ya existe, saltando instalación."
fi

# 10. DIRENV
status "Instalando Direnv"
sudo apt install -y direnv
if ! grep -q "direnv hook zsh" ~/.zshrc; then
  echo 'eval "$(direnv hook zsh)"' >>~/.zshrc
fi

# 11. STARSHIP
status "Instalando Starship Prompt"
curl -sS https://starship.rs/install.sh | sh -s -- -y

# 12. NEOVIM & LAZYVIM
status "Instalando Neovim y LazyVim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim*
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
# Crear enlace simbólico para que funcione el comando 'nvim'
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz

# Configuración LazyVim
if [ -d "$HOME/.config/nvim" ]; then
  echo "Ya existe configuración de nvim. Haciendo backup en nvim.bak"
  mv ~/.config/nvim ~/.config/nvim.bak
fi
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# 13. LAZYGIT
status "Instalando Lazygit"
sudo apt install -y lazygit

# 14. VISIDATA
status "Instalando Visidata con pipx"
pipx ensurepath
pipx install visidata

# 15. DOTFILES
status "Procesando Dotfiles"
DOTFILES_DIR="./dotfiles" # Asume que la carpeta está junto al script

if [ -d "$DOTFILES_DIR" ]; then
  echo -e "${BLUE}Carpeta 'dotfiles' detectada. Iniciando copia...${NC}"

  # El comando cp -rfv copia recursivamente, fuerza la sobreescritura y muestra qué hace.
  # El "/." al final es importante para copiar el contenido oculto (archivos que empiezan con .)
  cp -rfv "$DOTFILES_DIR/." "$HOME/"

  success "Archivos de configuración copiados y reemplazados: zshrc, i3, neovim, wezterm y mimeapps."
else
  echo -e "${RED}[!] ADVERTENCIA: No se encontró la carpeta 'dotfiles' en el directorio actual ($(pwd)).${NC}"
  echo "Saltando paso de configuración personalizada."
fi

echo -e "${BLUE}=== INSTALACIÓN COMPLETADA ===${NC}"
echo -e "${YELLOW}Por favor, realiza los siguientes pasos manuales:${NC}"
echo "1. Reinicia tu computadora para que los grupos de KVM (libvirt) surtan efecto."
echo "2. Abre una nueva terminal o ejecuta 'zsh' para cargar las configuraciones de Pyenv y Starship."
echo "3. Ejecuta 'sudo surfshark-vpn' para configurar tu VPN."
echo "4. Sincroniza la cuenta de Dropbox para acceder al Vault con Obsidian"
