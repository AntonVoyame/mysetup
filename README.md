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

El script `install` realiza las siguientes tareas de manera secuencial:

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

### 7. Keybindings

#### 🚀 Aplicaciones y Herramientas

| Atajo                       | Acción                      | Comando                     |
| :-------------------------- | :-------------------------- | :-------------------------- |
| `Super` + `Enter`           | Terminal (Wezterm)          | `wezterm`                   |
| `Super` + `Shift` + `Enter` | Terminal Scratchpad         | `scripts/scratchpad`        |
| `Super` + `b`               | Navegador (Brave)           | `brave-browser`             |
| `Super` + `Shift` + `b`     | Navegador Privado           | `brave-browser --incognito` |
| `Super` + `f`               | Gestor de Archivos (Thunar) | `thunar`                    |
| `Super` + `n`               | Editor de Texto (Geany)     | `geany`                     |
| `Super` + `d`               | Discord                     | `Discord`                   |
| `Super` + `o`               | Obsidian (Notas)            | `obsidian`                  |
| `Super` + `g`               | Dropbox (Iniciar sync)      | `dropbox start`             |
| `Super` + `v`               | Mezclador de Audio          | `pulsemixer`                |
| `Super` + `z`               | Menú de Aplicaciones (Rofi) | `rofi ...`                  |
| `Super` + `k`               | Script de Ayuda             | `scripts/help`              |

#### 🖥️ Sistema y Capturas

| Atajo                   | Acción                    | Comando           |
| :---------------------- | :------------------------ | :---------------- |
| `Super` + `x`           | Menú Apagar/Reiniciar     | `scripts/power`   |
| `Super` + `Shift` + `q` | Salir de i3 (Exit)        | `i3-msg exit`     |
| `Super` + `Shift` + `r` | Reiniciar i3 (Restart)    | `i3-msg restart`  |
| `Super` + `Shift` + `c` | Recargar config i3        | `i3-msg reload`   |
| `Super` + `Esc`         | Recargar config sxhkd     | `pkill ... sxhkd` |
| `Super` + `p`           | Captura Pantalla Completa | `flameshot full`  |
| `Super` + `Shift` + `p` | Captura Región            | `flameshot gui`   |

#### 🪟 Gestión de Ventanas

| Atajo                         | Acción            | Descripción        |
| :---------------------------- | :---------------- | :----------------- |
| `Super` + `q`                 | Cerrar Ventana    | Kill window        |
| `Super` + `Alt` + `f`         | Pantalla Completa | Toggle Fullscreen  |
| `Super` + `Shift` + `Espacio` | Flotante          | Toggle Floating    |
| `Super` + `Ctrl` + `Espacio`  | Alternar Foco     | Tiling / Floating  |
| `Super` + `s`                 | Layout: Apilado   | Stacking           |
| `Super` + `w`                 | Layout: Pestañas  | Tabbed             |
| `Super` + `t`                 | Layout: Dividido  | Split Toggle       |
| `Super` + `Ctrl` + `Flechas`  | Redimensionar     | Resize grow/shrink |

#### 🧭 Navegación (Estilo Vim)

| Atajo                     | Acción                     | Comando                   |
| :------------------------ | :------------------------- | :------------------------ |
| `Super` + `h`             | Foco Izquierda             | `focus left`              |
| `Super` + `j`             | Foco Abajo                 | `focus down`              |
| `Super` + `k`             | Foco Arriba                | `focus up`                |
| `Super` + `l`             | Foco Derecha               | `focus right`             |
| `Super` + `Shift` + `h`   | Mover Ventana Izquierda    | `move left`               |
| `Super` + `Shift` + `j`   | Mover Ventana Abajo        | `move down`               |
| `Super` + `Shift` + `k`   | Mover Ventana Arriba       | `move up`                 |
| `Super` + `Shift` + `l`   | Mover Ventana Derecha      | `move right`              |
| `Super` + `0-9`           | Ir al Espacio de Trabajo   | `workspace N`             |
| `Super` + `Shift` + `0-9` | Mover a Espacio de Trabajo | `move ... to workspace N` |

#### 📦 Scratchpad (Papelera temporal)

| Atajo                   | Acción              | Detalle                        |
| :---------------------- | :------------------ | :----------------------------- |
| `Super` + `-` (Menos)   | Enviar a Scratchpad | Oculta la ventana actual       |
| `Super` + `=` (Igual)   | Mostrar Scratchpad  | Muestra/Cicla ventanas ocultas |
| `Super` + `Shift` + `=` | Sacar de Scratchpad | Vuelve a hacerla "tiling"      |

#### 🔊 Audio y Brillo

| Atajo               | Acción           | Comando                     |
| :------------------ | :--------------- | :-------------------------- |
| `Super` + `F12`     | Subir Volumen    | `scripts/changevolume up`   |
| `Super` + `F11`     | Bajar Volumen    | `scripts/changevolume down` |
| `Super` + `F10`     | Mute             | `scripts/changevolume mute` |
| `Teclas Multimedia` | Volumen / Brillo | `pamixer` / `xbacklight`    |

## 🛠️ Instalación y Uso

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/AntonVoyame/mysetup
   cd mysetup
   chmod +x install
   ./install
   ```
