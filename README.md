# Linux Development Environment Setup

---

## ⚠️ Requisitos Previos

- Una distribución mínima basada en Debian/Ubuntu.
- Permisos de superusuario (`sudo`).
- Conexión a internet.
- Este script supone la instalación de **i3-setup** de [justaguylinux](https://codeberg.org/justaguylinux/i3-setup), con una terminal **zsh**, **wezterm**, etc.

---

## ⚠️ Configuración de VSCode

El script incluye los comandos necesarios para añadir el repositorio oficial de Microsoft e instalar **Visual Studio Code**.

> **Nota:** Por defecto, el script no instala Visual Studio Code. Si deseas instalarlo automáticamente, por favor utiliza la bandera **--vscode** o **-v**. La instrucción completa debería ser: **./install --vscode**, o **./install -v**.

---

Este repositorio contiene un script de **Bash** automatizado diseñado para aprovisionar y configurar una estación de trabajo de desarrollo sobre **Ubuntu/Debian**.

El objetivo es agilizar la instalación de herramientas esenciales, entornos de virtualización, lenguajes de programación y configuraciones personalizadas (dotfiles) en una instalación Debian + i3 (**Windows Manager**).

Suelo correr el script de [justaguylinux](https://codeberg.org/justaguylinux/i3-setup) sobre una instalación mínima de Debian, el cual instala y configura lo necesario para tener un WM operativo. Este script es solo un complemento personal, con el objetivo de responder a mi workflow y gusto personal.

## 🚀 Características

El script `install.sh` realiza las siguientes tareas de manera secuencial:

### 1. Core & System Utilities

- Actualización completa del sistema (`apt update && upgrade`).
- Instalación de herramientas de compilación (`build-essential`, `gcc`, `make`, `cmake`).
- Utilidades de línea de comandos: `curl`, `git`, `ripgrep`, `fd-find`, `xclip`, `unzip`, `ncdu`.

### 2. Virtualización (KVM/QEMU)

- Instalación y configuración de **KVM**, **QEMU**, **libvirt** y **Virt-Manager**.
- Configuración automática de grupos de usuario (`libvirt`, `kvm`) para gestión sin root.

### 3. Entorno Python

- Gestión de versiones de Python con **Pyenv**.
- Gestión de entornos virtuales y variables de entorno por directorio con **Direnv**.
- Herramientas adicionales: `pipx`.

### 4. Herramientas de Desarrollo y Productividad

- **Neovim:** Instalación de la última versión estable desde el binario oficial y configuración base con **LazyVim**.
- **Terminal:** Instalación y configuración de **Starship** prompt.
- **Utilidades de datos:** Instalación de **Visidata**.
- **Gestión Git:** Instalación de **Lazygit**.

### 5. Aplicaciones de Terceros

- Obsidian.
- Zoom.
- Dropbox.
- Surfshark VPN.

### 6. Gestión de Dotfiles

- El script detecta automáticamente una carpeta `./dotfiles` en la raíz del repositorio.
- Copia y reemplaza recursivamente las configuraciones en el `$HOME` del usuario, respetando la estructura de directorios.

## 🛠️ Instalación y Uso

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/AntonVoyame/mysetup
   cd mysetup
   chmod +x install.sh
   ./install.sh
   ```
