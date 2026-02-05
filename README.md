# Linux Development Environment Setup

Este repositorio contiene un script de **Bash** automatizado diseñado para aprovisionar y configurar una estación de trabajo de desarrollo sobre **Ubuntu/Debian**.

El objetivo es agilizar la instalación de herramientas esenciales, entornos de virtualización, lenguajes de programación y configuraciones personalizadas (dotfiles) en una instalación limpia del sistema operativo.

Antes de este script, suelo correr el script de #justaguylinux sobre una instalación mínima de Debian, el cual instala y configura lo necesario para tener un WM operativo. Este script es solo un complemento personal.

## 🚀 Características

El script `install.sh` realiza las siguientes tareas de manera secuencial:

### 1. Core & System Utilities

- Actualización completa del sistema (`apt update && upgrade`).
- Instalación de herramientas de compilación (`build-essential`, `gcc`, `make`, `cmake`).
- Utilidades de línea de comandos: `curl`, `git`, `ripgrep`, `fd-find`, `xclip`, `unzip`.

### 2. Virtualización (KVM/QEMU)

- Instalación y configuración de **KVM**, **QEMU**, **libvirt** y **Virt-Manager**.
- Configuración automática de grupos de usuario (`libvirt`, `kvm`) para gestión sin root.

### 3. Entorno Python

- Gestión de versiones de Python con **Pyenv**.
- Gestión de entornos virtuales y variables de entorno por directorio con **Direnv**.
- Herramientas adicionales: `pipx`, `poetry` (vía pipx).

### 4. Herramientas de Desarrollo y Productividad

- **Neovim:** Instalación de la última versión estable desde el binario oficial y configuración base con **LazyVim**.
- **Terminal:** Instalación y configuración de **Starship** prompt.
- **Utilidades de datos:** Instalación de **Visidata**.
- **Gestión Git:** Instalación de **Lazygit**.

### 5. Aplicaciones de Terceros

- Obsidian (Última versión oficial).
- Zoom.
- Dropbox.
- Surfshark VPN.

### 6. Gestión de Dotfiles

- El script detecta automáticamente una carpeta `./dotfiles` en la raíz del repositorio.
- Copia y reemplaza recursivamente las configuraciones en el `$HOME` del usuario, respetando la estructura de directorios.

---

## ⚠️ Configuración de VSCode

El script incluye los comandos necesarios para añadir el repositorio oficial de Microsoft e instalar **Visual Studio Code**.

> **Nota:** Por defecto, la sección de instalación de VSCode se encuentra **comentada/deshabilitada** dentro del script `install.sh`. Si deseas instalar VSCode automáticamente, por favor edita el archivo y descomenta las líneas correspondientes en la sección "VSCODE".

---

## 📋 Requisitos Previos

- Una distribución basada en Debian/Ubuntu.
- Permisos de superusuario (`sudo`).
- Conexión a internet.
- (Opcional) Una shell `zsh` instalada previamente es recomendada, ya que el script inyecta configuraciones en `~/.zshrc`.

## 🛠️ Instalación y Uso

1. **Clonar el repositorio:**

   ```bash
   git clone [https://github.com/AntonVoyame/mysetup](https://github.com/AntonVoyame/mysetup.git)
   cd mysetup
   chmod +x install.sh
   ./install.sh
   ```
