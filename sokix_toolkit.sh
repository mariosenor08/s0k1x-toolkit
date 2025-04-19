#!/bin/bash

# SOKIX Toolkit - Enterprise Edition
# Developed for Kali Linux
# Version: 2.0.0

# Strict mode
set -euo pipefail
IFS=$'\n\t'

# Global Configuration
readonly VERSION="2.0.0"
readonly TOOLKIT_NAME="SOKIX"
readonly CONFIG_FILE="/etc/sokix/config.yaml"
readonly LOG_FILE="/var/log/sokix/toolkit.log"

# Base Directories
readonly TOOLKIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TOOLS_DIR="$TOOLKIT_ROOT/tools"
readonly LOG_DIR="$TOOLKIT_ROOT/logs"
readonly CONFIG_DIR="$TOOLKIT_ROOT/config"
readonly TEMP_DIR="$TOOLKIT_ROOT/temp"
readonly BACKUP_DIR="$TOOLKIT_ROOT/backups"
readonly CACHE_DIR="$TOOLKIT_ROOT/cache"

# System Requirements
readonly MIN_RAM_MB=1024
readonly MIN_DISK_GB=10
readonly REQUIRED_COMMANDS=("git" "curl" "wget" "python3" "pip3" "awk" "sed" "grep" "tar" "unzip")

# Colores y estilos mejorados
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
ORANGE='\033[1;38;5;208m'
PINK='\033[1;38;5;206m'
LIME='\033[1;38;5;118m'
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'
BLINK='\033[5m'
REVERSE='\033[7m'
HIDDEN='\033[8m'
NC='\033[0m'

# Caracteres Unicode mejorados
BORDER_TOP="╭─────────────────────────────────────────────────────────────────╮"
BORDER_BOTTOM="╰─────────────────────────────────────────────────────────────────╯"
BORDER_SIDE="│"
BORDER_MIDDLE="├─────────────────────────────────────────────────────────────────┤"
SPARKLE="✨"
CHECK="✓"
WARNING="⚠"
ERROR="✗"
INFO="ℹ"
STAR="★"
DIAMOND="♦"
HEART="♥"
ARROW="➜"
LOADING=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
PROGRESS_BAR_FILL="█"
PROGRESS_BAR_EMPTY="░"
BULLET="•"
CROSS="✖"
LOCK="🔒"
UNLOCK="🔓"
KEY="🔑"
SHIELD="🛡️"
SWORD="⚔️"
WRENCH="🔧"
GEAR="⚙️"
LIGHTNING="⚡"
FIRE="🔥"
TARGET="🎯"
SKULL="💀"
GHOST="👻"
ROBOT="🤖"
TERMINAL="💻"
SATELLITE="📡"
MAGNIFIER="🔍"
TOOLS="🛠️"
DOWNLOAD="📥"
SUCCESS="✅"
FAILED="❌"
LOADING_WHEEL="🔄"
PACKAGE="📦"
CLOCK="⏰"
CHART="📊"
FOLDER="📁"

# Enhanced Logging System
log_info() {
    local message="$1"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${BLUE}[INFO]${NC} $message"
    echo "[$timestamp] [INFO] $message" >> "$LOG_FILE"
}

log_error() {
    local message="$1"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${RED}[ERROR]${NC} $message"
    echo "[$timestamp] [ERROR] $message" >> "$LOG_FILE"
}

log_warning() {
    local message="$1"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${YELLOW}[WARNING]${NC} $message"
    echo "[$timestamp] [WARNING] $message" >> "$LOG_FILE"
}

log_success() {
    local message="$1"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${GREEN}[SUCCESS]${NC} $message"
    echo "[$timestamp] [SUCCESS] $message" >> "$LOG_FILE"
}

# Enhanced User Interface
show_menu() {
    clear
    echo -e "${BLUE}${BOLD}=== $TOOLKIT_NAME v$VERSION ===${NC}"
    echo -e "${CYAN}${BOLD}Menú Principal${NC}"
    echo -e "${GREEN}1.${NC} Herramientas de Explotación"
    echo -e "${GREEN}2.${NC} Herramientas de Red"
    echo -e "${GREEN}3.${NC} Herramientas Web"
    echo -e "${GREEN}4.${NC} Herramientas Forenses"
    echo -e "${GREEN}5.${NC} Herramientas Criptográficas"
    echo -e "${GREEN}6.${NC} Herramientas de Ingeniería Inversa"
    echo -e "${GREEN}7.${NC} Herramientas Wireless"
    echo -e "${GREEN}8.${NC} Herramientas de Malware"
    echo -e "${GREEN}9.${NC} Herramientas OSINT"
    echo -e "${GREEN}10.${NC} Motores de Búsqueda"
    echo -e "${GREEN}11.${NC} Verificación de Cuentas"
    echo -e "${GREEN}12.${NC} Configuración"
    echo -e "${GREEN}13.${NC} Actualizar Toolkit"
    echo -e "${GREEN}14.${NC} Salir"
    echo -e "${YELLOW}${BOLD}Seleccione una opción:${NC} "
}

show_submenu() {
    local category=$1
    local -n tools=$2
    local title=$3
    
    clear
    echo -e "${BLUE}${BOLD}=== $TOOLKIT_NAME v$VERSION ===${NC}"
    echo -e "${CYAN}${BOLD}$title${NC}"
    
    local i=1
    for tool in "${!tools[@]}"; do
        IFS='|' read -r name description repo_url <<< "${tools[$tool]}"
        echo -e "${GREEN}$i.${NC} $name - $description"
        ((i++))
    done
    
    echo -e "${YELLOW}${BOLD}Seleccione una herramienta (o 'b' para volver):${NC} "
}

# Enhanced Error Handling
handle_error() {
    local error_code=$1
    local error_message=$2
    
    case $error_code in
        1) log_error "Error de permisos: $error_message" ;;
        2) log_error "Error de red: $error_message" ;;
        3) log_error "Error de dependencias: $error_message" ;;
        4) log_error "Error de instalación: $error_message" ;;
        5) log_error "Error de configuración: $error_message" ;;
        *) log_error "Error desconocido: $error_message" ;;
    esac
    
    echo -e "${RED}${BOLD}Error:${NC} $error_message"
    echo -e "${YELLOW}Presione Enter para continuar...${NC}"
    read
}

# Enhanced System Validation
validate_system() {
    log_info "Validando sistema..."
    
    # Check RAM
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    if [ "$total_ram" -lt "$MIN_RAM_MB" ]; then
        handle_error 1 "RAM insuficiente. Se requieren al menos $MIN_RAM_MB MB"
        return 1
    fi
    
    # Check disk space
    local free_space=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
    if [ "$free_space" -lt "$MIN_DISK_GB" ]; then
        handle_error 1 "Espacio en disco insuficiente. Se requieren al menos $MIN_DISK_GB GB"
        return 1
    fi
    
    # Check required commands
    for cmd in "${REQUIRED_COMMANDS[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            handle_error 3 "Comando requerido no encontrado: $cmd"
            return 1
        fi
    done
    
    log_success "Validación del sistema completada"
    return 0
}

# Logging Functions
log() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
}

log_info() { log "INFO" "$1"; }
log_warn() { log "WARN" "$1"; }
log_error() { log "ERROR" "$1"; }
log_debug() { log "DEBUG" "$1"; }

# Error Handling
handle_error() {
    local exit_code=$?
    local line_number=$1
    log_error "Error on line $line_number: Exit code $exit_code"
    echo -e "${RED}${ERROR} Error en línea $line_number. Consulte $LOG_FILE para más detalles.${NC}"
    cleanup_and_exit 1
}

trap 'handle_error ${LINENO}' ERR

# System Validation
check_system_requirements() {
    log_info "Verificando requisitos del sistema..."
    
    # Check RAM
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    if [ "$total_ram" -lt "$MIN_RAM_MB" ]; then
        log_error "RAM insuficiente: $total_ram MB (mínimo: $MIN_RAM_MB MB)"
        echo -e "${RED}${ERROR} RAM insuficiente para ejecutar el toolkit${NC}"
        return 1
    fi
    
    # Check Disk Space
    local free_space=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
    if [ "$free_space" -lt "$MIN_DISK_GB" ]; then
        log_error "Espacio en disco insuficiente: $free_space GB (mínimo: $MIN_DISK_GB GB)"
        echo -e "${RED}${ERROR} Espacio en disco insuficiente${NC}"
        return 1
    fi
    
    # Check Required Commands
    for cmd in "${REQUIRED_COMMANDS[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            log_error "Comando requerido no encontrado: $cmd"
            echo -e "${RED}${ERROR} Comando requerido no encontrado: $cmd${NC}"
            return 1
        fi
    done
    
    # Check Root Access
    if [ "$EUID" -ne 0 ]; then
        log_error "Se requieren privilegios de root"
        echo -e "${RED}${ERROR} Este script necesita privilegios de root${NC}"
        echo -e "${YELLOW}Ejecute: sudo $0${NC}"
        return 1
    fi
    
    # Check Kali Linux
    if ! grep -q 'Kali' /etc/os-release; then
        log_warn "No se detectó Kali Linux. Algunas funciones podrían no estar disponibles."
        echo -e "${YELLOW}${WARNING} No se detectó Kali Linux. Algunas funciones podrían no estar disponibles.${NC}"
    fi
    
    log_info "Verificación de requisitos completada exitosamente"
    return 0
}

# Directory Management
create_directory_structure() {
    log_info "Creando estructura de directorios..."
    
    local directories=(
        "$TOOLS_DIR"
        "$LOG_DIR"
        "$CONFIG_DIR"
        "$TEMP_DIR"
        "$BACKUP_DIR"
        "$CACHE_DIR"
        "$TOOLS_DIR/exploitation"
        "$TOOLS_DIR/network"
        "$TOOLS_DIR/web"
        "$TOOLS_DIR/forensics"
        "$TOOLS_DIR/crypto"
        "$TOOLS_DIR/reverse"
        "$TOOLS_DIR/wireless"
        "$TOOLS_DIR/malware"
        "$TOOLS_DIR/osint"
        "$TOOLS_DIR/search"
        "$TOOLS_DIR/verification"
    )
    
    for dir in "${directories[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            chmod 750 "$dir"
            log_info "Directorio creado: $dir"
            echo -e "${GREEN}${CHECK} Directorio creado: $dir${NC}"
        fi
    done
    
    # Create log rotation configuration
    cat > "$CONFIG_DIR/logrotate.conf" << EOF
$LOG_FILE {
    rotate 7
    daily
    compress
    delaycompress
    missingok
    notifempty
    create 640 $USER $USER
}
EOF
    
    log_info "Estructura de directorios creada exitosamente"
}

# Configuration Management
load_configuration() {
    if [ -f "$CONFIG_FILE" ]; then
        log_info "Cargando configuración desde $CONFIG_FILE"
        source "$CONFIG_FILE"
    else
        log_warn "Archivo de configuración no encontrado, usando valores predeterminados"
        create_default_config
    fi
}

create_default_config() {
    log_info "Creando configuración predeterminada"
    cat > "$CONFIG_FILE" << EOF
# SOKIX Toolkit Configuration
toolkit_version: $VERSION
update_check: true
auto_backup: true
max_log_size: 100M
debug_mode: false
proxy_enabled: false
proxy_address: ""
tool_categories:
  - exploitation
  - network
  - web
  - forensics
  - crypto
  - reverse
  - wireless
  - malware
  - osint
EOF
    chmod 640 "$CONFIG_FILE"
    chown root:root "$CONFIG_FILE"
}

# Improved Splash Screen
show_splash_screen() {
    # Check terminal support
    if [ -z "$TERM" ] || [ "$TERM" = "dumb" ]; then
        echo "SOKIX Toolkit v$VERSION"
        return
    fi

    # Get terminal dimensions
    local cols=$(tput cols)
    local lines=$(tput lines)
    
    # Minimum size check
    if [ "$cols" -lt 80 ] || [ "$lines" -lt 24 ]; then
        echo -e "${RED}${ERROR} Terminal too small. Minimum size: 80x24${NC}"
        echo "Current size: ${cols}x${lines}"
        sleep 2
        return
    fi

    clear
    local mid_row=$((lines/2))
    local mid_col=$((cols/2))
    
    # Animated border with error handling
    for ((i=0; i<cols; i++)); do
        tput cup 0 $i 2>/dev/null && echo -n "${RED}═${NC}" || break
        tput cup $((lines-1)) $i 2>/dev/null && echo -n "${RED}═${NC}" || break
        sleep 0.01
    done
    
    for ((i=0; i<lines; i++)); do
        tput cup $i 0 2>/dev/null && echo -n "${RED}║${NC}" || break
        tput cup $i $((cols-1)) 2>/dev/null && echo -n "${RED}║${NC}" || break
        sleep 0.01
    done
    
    # Corner characters
    tput cup 0 0 2>/dev/null && echo -n "${RED}╔${NC}"
    tput cup 0 $((cols-1)) 2>/dev/null && echo -n "${RED}╗${NC}"
    tput cup $((lines-1)) 0 2>/dev/null && echo -n "${RED}╚${NC}"
    tput cup $((lines-1)) $((cols-1)) 2>/dev/null && echo -n "${RED}╝${NC}"
    
    # Logo with error handling
    local logo=(
        "███████╗ ██████╗ ██╗  ██╗██╗██╗  ██╗"
        "██╔════╝██╔═══██╗██║ ██╔╝██║╚██╗██╔╝"
        "███████╗██║   ██║█████╔╝ ██║ ╚███╔╝ "
        "╚════██║██║   ██║██╔═██╗ ██║ ██╔██╗ "
        "███████║╚██████╔╝██║  ██╗██║██╔╝ ██╗"
        "╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝"
    )
    
    local logo_height=${#logo[@]}
    local logo_width=${#logo[0]}
    local start_row=$((mid_row - logo_height/2))
    local start_col=$((mid_col - logo_width/2))
    
    for ((i=0; i<${#logo[@]}; i++)); do
        tput cup $((start_row + i)) $start_col 2>/dev/null && echo -e "${CYAN}${logo[$i]}${NC}" || break
        sleep 0.1
    done
    
    # Version and info with error handling
    tput cup $((start_row + logo_height + 1)) $((mid_col - 20)) 2>/dev/null && \
        echo -e "${YELLOW}${SHIELD} Professional Penetration Testing Toolkit ${SHIELD}${NC}"
    
    tput cup $((start_row + logo_height + 2)) $((mid_col - 15)) 2>/dev/null && \
        echo -e "${WHITE}Version ${VERSION} | Kali Linux Edition${NC}"
    
    sleep 2
    clear
}

show_styled_progress() {
    local current=$1
    local total=$2
    local title=$3
    local width=50
    local percent=$((current * 100 / total))
    local filled=$((width * current / total))
    local empty=$((width - filled))
    local spin_idx=$((current % ${#LOADING[@]}))
    
    printf "\r${BLUE}${LOADING[$spin_idx]} ${WHITE}%-30s${NC} " "$title"
    printf "[${CYAN}"
    printf "%${filled}s" | tr " " "${PROGRESS_BAR_FILL}"
    printf "${NC}"
    printf "%${empty}s" | tr " " "${PROGRESS_BAR_EMPTY}"
    printf "] ${YELLOW}%3d%%${NC}" "$percent"
}

show_tool_banner() {
    local tool_name=$1
    local version=$2
    local category=$3
    
    echo -e "\n${BLUE}${BORDER_TOP}${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${TOOLS} ${WHITE}$tool_name v$version${NC} ${BLUE}${BORDER_SIDE}${NC}"
    echo -e "${BLUE}${BORDER_MIDDLE}${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${FOLDER} Categoría: ${GREEN}$category${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${INFO} Estado: ${LIME}Activo${NC}"
    echo -e "${BLUE}${BORDER_BOTTOM}${NC}\n"
}

# Tool Management
verify_tool_integrity() {
    local tool_path=$1
    local expected_hash=$2
    
    if [ -f "$tool_path" ]; then
        local actual_hash=$(sha256sum "$tool_path" | cut -d' ' -f1)
        if [ "$actual_hash" = "$expected_hash" ]; then
            return 0
        fi
    fi
    return 1
}

# Enhanced Installation System
install_all_tools() {
    local total_tools=0
    local installed_tools=0
    local failed_tools=0
    
    # Count total tools
    for category in "${!financial_analysis_tools[@]}" "${!asset_tracking_tools[@]}" "${!human_rights_tools[@]}" "${!conflict_monitoring_tools[@]}" "${!terrorism_monitoring_tools[@]}" "${!darkweb_monitoring_tools[@]}"; do
        ((total_tools++))
    done
    
    echo -e "\n${BLUE}${BORDER_TOP}${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${DOWNLOAD} ${WHITE}Instalando herramientas...${NC} ${BLUE}${BORDER_SIDE}${NC}"
    echo -e "${BLUE}${BORDER_MIDDLE}${NC}"
    
    # Install Financial Analysis Tools
    for tool in "${!financial_analysis_tools[@]}"; do
        IFS='|' read -r name description repo_url <<< "${financial_analysis_tools[$tool]}"
        show_styled_progress $((installed_tools + failed_tools + 1)) $total_tools "Instalando $name"
        if install_tool "financial" "$tool"; then
            ((installed_tools++))
        else
            ((failed_tools++))
        fi
    done
    
    # Install Asset Tracking Tools
    for tool in "${!asset_tracking_tools[@]}"; do
        IFS='|' read -r name description repo_url <<< "${asset_tracking_tools[$tool]}"
        show_styled_progress $((installed_tools + failed_tools + 1)) $total_tools "Instalando $name"
        if install_tool "asset" "$tool"; then
            ((installed_tools++))
        else
            ((failed_tools++))
        fi
    done
    
    # Install Human Rights Tools
    for tool in "${!human_rights_tools[@]}"; do
        IFS='|' read -r name description repo_url <<< "${human_rights_tools[$tool]}"
        show_styled_progress $((installed_tools + failed_tools + 1)) $total_tools "Instalando $name"
        if install_tool "human" "$tool"; then
            ((installed_tools++))
        else
            ((failed_tools++))
        fi
    done
    
    # Install Conflict Monitoring Tools
    for tool in "${!conflict_monitoring_tools[@]}"; do
        IFS='|' read -r name description repo_url <<< "${conflict_monitoring_tools[$tool]}"
        show_styled_progress $((installed_tools + failed_tools + 1)) $total_tools "Instalando $name"
        if install_tool "conflict" "$tool"; then
            ((installed_tools++))
        else
            ((failed_tools++))
        fi
    done
    
    # Install Terrorism Monitoring Tools
    for tool in "${!terrorism_monitoring_tools[@]}"; do
        IFS='|' read -r name description repo_url <<< "${terrorism_monitoring_tools[$tool]}"
        show_styled_progress $((installed_tools + failed_tools + 1)) $total_tools "Instalando $name"
        if install_tool "terrorism" "$tool"; then
            ((installed_tools++))
        else
            ((failed_tools++))
        fi
    done
    
    # Install Dark Web Monitoring Tools
    for tool in "${!darkweb_monitoring_tools[@]}"; do
        IFS='|' read -r name description repo_url <<< "${darkweb_monitoring_tools[$tool]}"
        show_styled_progress $((installed_tools + failed_tools + 1)) $total_tools "Instalando $name"
        if install_tool "darkweb" "$tool"; then
            ((installed_tools++))
        else
            ((failed_tools++))
        fi
    done
    
    echo -e "\n${BLUE}${BORDER_MIDDLE}${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${SUCCESS} Herramientas instaladas: $installed_tools${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${ERROR} Herramientas fallidas: $failed_tools${NC}"
    echo -e "${BLUE}${BORDER_BOTTOM}${NC}"
    
    return $((failed_tools > 0))
}

# Enhanced Tool Installation
install_tool() {
    local category=$1
    local tool_name=$2
    local tool_dir="$TOOLS_DIR/$category/$tool_name"
    local max_retries=3
    local retry_count=0
    
    # Log installation attempt
    log_info "Intentando instalar $tool_name en la categoría $category"
    
    # Get tool information
    local tool_info
    case "$category" in
        "network") tool_info="${network_scanning_tools[$tool_name]}" ;;
        "vulnerability") tool_info="${vulnerability_scanning_tools[$tool_name]}" ;;
        "password") tool_info="${password_cracking_tools[$tool_name]}" ;;
        "exploitation") tool_info="${exploitation_tools[$tool_name]}" ;;
        "packet") tool_info="${packet_sniffing_tools[$tool_name]}" ;;
        "wireless") tool_info="${wireless_hacking_tools[$tool_name]}" ;;
        "webapp") tool_info="${web_app_hacking_tools[$tool_name]}" ;;
        "forensics") tool_info="${forensics_tools[$tool_name]}" ;;
        "social") tool_info="${social_engineering_tools[$tool_name]}" ;;
        "misc") tool_info="${miscellaneous_tools[$tool_name]}" ;;
        "search") tool_info="${search_engines_tools[$tool_name]}" ;;
        "verification") tool_info="${account_verification_tools[$tool_name]}" ;;
        "financial") tool_info="${financial_analysis_tools[$tool_name]}" ;;
        "asset") tool_info="${asset_tracking_tools[$tool_name]}" ;;
        "human") tool_info="${human_rights_tools[$tool_name]}" ;;
        "conflict") tool_info="${conflict_monitoring_tools[$tool_name]}" ;;
        "terrorism") tool_info="${terrorism_monitoring_tools[$tool_name]}" ;;
        "darkweb") tool_info="${darkweb_monitoring_tools[$tool_name]}" ;;
        "email") tool_info="${email_tools[$tool_name]}" ;;
        *)
            log_error "Categoría desconocida: $category"
            return 1
            ;;
    esac
    
    if [ -z "$tool_info" ]; then
        log_error "No se encontró información para la herramienta $tool_name"
        return 1
    fi
    
    IFS='|' read -r name description repo_url <<< "$tool_info"
    
    if [ -z "$repo_url" ]; then
        log_error "URL del repositorio no disponible para $tool_name"
        return 1
    fi
    
    # Create directory if it doesn't exist
    if ! mkdir -p "$tool_dir"; then
        log_error "No se pudo crear el directorio para $tool_name"
        return 1
    fi
    
    while [ $retry_count -lt $max_retries ]; do
        log_info "Intento $((retry_count + 1)) de $max_retries para instalar $tool_name"
        
        if [[ "$repo_url" == *.git ]]; then
            if git clone --depth 1 "$repo_url" "$tool_dir" 2>/dev/null; then
                log_success "Repositorio clonado exitosamente: $tool_name"
                break
            fi
        else
            if wget -q -O "$tool_dir/$tool_name" "$repo_url"; then
                log_success "Herramienta descargada exitosamente: $tool_name"
                break
            fi
        fi
        
        ((retry_count++))
        log_warn "Intento $retry_count fallido para $tool_name"
        sleep 2
    done
    
    if [ $retry_count -eq $max_retries ]; then
        log_error "No se pudo instalar $tool_name después de $max_retries intentos"
        return 1
    fi
    
    # Install dependencies if requirements.txt exists
    if [ -f "$tool_dir/requirements.txt" ]; then
        log_info "Instalando dependencias para $tool_name"
        if ! pip3 install -r "$tool_dir/requirements.txt"; then
            log_error "Error al instalar dependencias para $tool_name"
            return 1
        fi
    fi
    
    # Make executable if needed
    if [ -f "$tool_dir/$tool_name" ]; then
        chmod +x "$tool_dir/$tool_name"
    fi
    
    # Create launcher script
    cat > "$tool_dir/launch.sh" << EOF
#!/bin/bash
cd "$tool_dir"
if [ -f "$tool_name" ]; then
    ./$tool_name "\$@"
elif [ -f "main.py" ]; then
    python3 main.py "\$@"
elif [ -f "index.html" ]; then
    python3 -m http.server 8000
else
    echo "No se pudo encontrar el punto de entrada de la herramienta"
    exit 1
fi
EOF
    
    chmod +x "$tool_dir/launch.sh"
    log_success "Herramienta $tool_name instalada exitosamente"
    return 0
}

# Main Menu Interface
show_main_menu() {
    clear
    echo -e "${BLUE}${BORDER_TOP}${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${FIRE} ${BOLD}${WHITE}$TOOLKIT_NAME TOOLKIT v$VERSION${NC} ${FIRE} ${BLUE}${BORDER_SIDE}${NC}"
    echo -e "${BLUE}${BORDER_MIDDLE}${NC}"
    
    # System Information
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${INFO} Sistema: $(uname -a | cut -d' ' -f1,3,12)${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${TERMINAL} IP: $(hostname -I | cut -d' ' -f1)${NC}"
    echo -e "${BLUE}${BORDER_SIDE}${NC} ${CLOCK} Uptime: $(uptime -p)${NC}"
    
    echo -e "${BLUE}${BORDER_MIDDLE}${NC}"
    
    # Menu Categories
    echo -e "${GREEN}1.${NC} Herramientas de Red"
    echo -e "${GREEN}2.${NC} Herramientas de Vulnerabilidades"
    echo -e "${GREEN}3.${NC} Herramientas de Contraseñas"
    echo -e "${GREEN}4.${NC} Herramientas de Explotación"
    echo -e "${GREEN}5.${NC} Herramientas de Paquetes"
    echo -e "${GREEN}6.${NC} Herramientas Inalámbricas"
    echo -e "${GREEN}7.${NC} Herramientas Web"
    echo -e "${GREEN}8.${NC} Herramientas Forenses"
    echo -e "${GREEN}9.${NC} Herramientas de Ingeniería Social"
    echo -e "${GREEN}10.${NC} Motores de Búsqueda"
    echo -e "${GREEN}11.${NC} Verificación de Cuentas"
    echo -e "${GREEN}12.${NC} Análisis Financiero"
    echo -e "${GREEN}13.${NC} Seguimiento de Activos"
    echo -e "${GREEN}14.${NC} Derechos Humanos"
    echo -e "${GREEN}15.${NC} Monitoreo de Conflictos"
    echo -e "${GREEN}16.${NC} Monitoreo de Terrorismo"
    echo -e "${GREEN}17.${NC} Monitoreo de Dark Web"
    echo -e "${GREEN}18.${NC} Herramientas de Email"
    echo -e "${GREEN}19.${NC} Herramientas Varias"
    echo -e "${GREEN}20.${NC} Configuración"
    echo -e "${GREEN}21.${NC} Actualizar Toolkit"
    echo -e "${GREEN}22.${NC} Salir"
    
    echo -e "${BLUE}${BORDER_BOTTOM}${NC}"
    echo -e "\n${YELLOW}${ARROW} Seleccione una opción: ${NC}"
}

# Improved Tool Display
show_category_menu() {
    local category=$1
    local title=$2
    local -n tools=$3
    
    # Validate parameters
    if [ -z "$category" ] || [ -z "$title" ]; then
        log_error "Parámetros inválidos en show_category_menu"
        return 1
    fi
    
    # Check if tools array is empty
    if [ ${#tools[@]} -eq 0 ]; then
        log_warn "No hay herramientas disponibles en la categoría $category"
        echo -e "${YELLOW}${WARNING} No hay herramientas disponibles en esta categoría${NC}"
        echo -e "\n${YELLOW}Presione ENTER para continuar...${NC}"
        read
        return 0
    }
    
    # Check terminal size
    local cols=$(tput cols)
    local lines=$(tput lines)
    if [ "$cols" -lt 80 ] || [ "$lines" -lt 24 ]; then
        echo -e "${RED}${ERROR} Terminal demasiado pequeña. Tamaño mínimo: 80x24${NC}"
        echo "Tamaño actual: ${cols}x${lines}"
        sleep 2
        return 1
    fi
    
    while true; do
        clear
        echo -e "${BLUE}${BORDER_TOP}${NC}"
        echo -e "${BLUE}${BORDER_SIDE}${NC} ${TOOLS} ${WHITE}$title${NC} ${BLUE}${BORDER_SIDE}${NC}"
        echo -e "${BLUE}${BORDER_MIDDLE}${NC}"
        
        local idx=1
        for tool in "${!tools[@]}"; do
            IFS='|' read -r name description repo_url <<< "${tools[$tool]}"
            # Truncate description if too long
            local max_desc_length=$((cols - 20))
            if [ ${#description} -gt $max_desc_length ]; then
                description="${description:0:$max_desc_length}..."
            fi
            
            # Check if tool is installed
            local status_icon
            if [ -d "$TOOLS_DIR/$category/$tool" ]; then
                status_icon="${GREEN}${CHECK}${NC}"
            else
                status_icon="${RED}${CROSS}${NC}"
            fi
            
            echo -e "${BLUE}${BORDER_SIDE}${NC} $status_icon ${GREEN}[$idx]${NC} $name - ${WHITE}$description${NC}"
            ((idx++))
        done
        
        echo -e "${BLUE}${BORDER_MIDDLE}${NC}"
        echo -e "${BLUE}${BORDER_SIDE}${NC} ${GREEN}[0]${NC} Volver al menú principal"
        echo -e "${BLUE}${BORDER_BOTTOM}${NC}"
        
        echo -e "\n${YELLOW}${ARROW} Seleccione una herramienta (0-$((idx-1))): ${NC}"
        read -r option
        
        case $option in
            0) return ;;
            [1-9]|[1-9][0-9])
                if [ "$option" -le "${#tools[@]}" ]; then
                    local tool_name=$(echo "${!tools[@]}" | cut -d' ' -f$option)
                    run_tool "$category" "$tool_name"
                else
                    echo -e "${RED}${ERROR} Opción inválida${NC}"
                    sleep 1
                fi
                ;;
            *)
                echo -e "${RED}${ERROR} Opción inválida${NC}"
                sleep 1
                ;;
        esac
    done
}

# Tool Categories
declare -A financial_analysis_tools=(
    # Financial Intelligence Tools
    ["acfcs"]="ACFCS|Association of Certified Financial Crime Specialists|https://www.acfcs.org"
    ["fatf"]="FATF|Financial Action Task Force|http://www.fatf-gafi.org"
    ["fincen"]="FinCEN|Financial Crimes Enforcement Network|https://www.fincen.gov"
    ["imolin"]="IMOLIN|International Money Laundering Information Network|http://www.imolin.org"
    ["occrp"]="OCCRP|Organized Crime and Corruption Reporting Project|https://www.occrp.org"
    ["european-anti-fraud"]="European Anti-Fraud|Office for Anti-Fraud Coordination|https://ec.europa.eu/anti-fraud"
    ["transparency"]="Transparency International|Global Anti-Corruption Organization|https://www.transparency.org"
    ["unodc"]="UNODC|United Nations Office on Drugs and Crime|https://www.unodc.org/unodc/en/corruption/index.html"
    
    # Financial Analysis Tools
    ["aml-analyzer"]="AML Analyzer|Anti-Money Laundering Analysis Tool|https://github.com/aml-analyzer/aml-analyzer"
    ["transaction-monitor"]="Transaction Monitor|Financial Transaction Analysis|https://github.com/transaction-monitor/transaction-monitor"
    ["fraud-detection"]="Fraud Detection|Pattern Recognition System|https://github.com/fraud-detection/fraud-detection"
    ["risk-assessment"]="Risk Assessment|Financial Risk Analysis|https://github.com/risk-assessment/risk-assessment"
    ["compliance-checker"]="Compliance Checker|Regulatory Compliance Tool|https://github.com/compliance-checker/compliance-checker"
    
    # Forensic Analysis Tools
    ["financial-forensics"]="Financial Forensics|Digital Forensic Analysis|https://github.com/financial-forensics/financial-forensics"
    ["blockchain-analyzer"]="Blockchain Analyzer|Cryptocurrency Analysis|https://github.com/blockchain-analyzer/blockchain-analyzer"
    ["transaction-tracer"]="Transaction Tracer|Payment Flow Analysis|https://github.com/transaction-tracer/transaction-tracer"
    ["pattern-recognition"]="Pattern Recognition|Anomaly Detection|https://github.com/pattern-recognition/pattern-recognition"
    ["data-mining"]="Data Mining|Financial Data Analysis|https://github.com/data-mining/data-mining"
)

declare -A asset_tracking_tools=(
    # Art and Cultural Heritage Tracking
    ["art-loss"]="Art Loss Register|Registro de obras de arte robadas|http://www.artloss.com"
    ["culture-crime"]="Culture Crime News|Noticias sobre delitos culturales|http://news.culturecrime.org"
    ["icom-red-lists"]="ICOM Red Lists|Listas de bienes culturales en riesgo|http://icom.museum/en/resources/red-lists"
    ["world-museum"]="World Museum Community|Comunidad de museos mundial|https://icom.museum/en/resources/red-lists"
    
    # Vehicle and Property Tracking
    ["hotgunz"]="HotGunz|Registro de armas robadas|http://www.hotgunz.com"
    ["immobilise"]="Immobilise|Registro nacional de bienes robados|https://www.immobilise.com"
    ["stolen-911"]="Stolen 911|Registro de bienes robados en EEUU|https://stolen911.com"
    ["stolen-boats"]="Stolen Boats|Registro de barcos robados|http://www.stolenboats.org.uk"
    ["stolen-caravan"]="Stolen Caravan|Registro de caravanas robadas|http://www.ukcampsite.co.uk/articles/view.asp?id=108"
    ["stolen-register"]="Stolen Register|Registro global de bienes robados|http://www.stolenregister.com/search"
    
    # Fraud Prevention and Reporting
    ["bbb-scam-tracker"]="BBB Scam Tracker|Rastreador de estafas|https://www.bbb.org/scamtracker/us/"
    ["canadian-police"]="Canadian Police Stolen|Registro de bienes robados canadiense|http://www.cpic-cipc.ca/index-eng.htm"
    ["its-been-nicked"]="It's BEEN NICKED|Registro de bienes robados|http://www.itsbeennicked.co.uk"
    ["recipero"]="Recipero|Sistema de recuperación de bienes|https://www.recipero.com"
    ["scrap-theft"]="Scrap Theft Alert|Alerta de robo de chatarra|https://www.scraptheftalert.com/Home/Home.aspx"
    ["securius"]="Securius|Base de datos de bienes robados|https://www.securius.eu/de/datenbank"
    
    # Device and Asset Tracking
    ["prey-project"]="Prey Project|Seguimiento de dispositivos|https://www.preyproject.com"
    ["watch-register"]="The Watch Register|Registro de relojes robados|http://www.thewatchregister.com"
    ["gumtree-stolen"]="Gumtree Lost & Found|Registro de bienes robados|https://www.gumtree.com/lost-found-stuff/uk/stolen"
)

declare -A human_rights_tools=(
    # Global Monitoring and Statistics
    ["global-incident"]="Global Incident Map|Mapa global de incidentes|http://human.globalincidentmap.com"
    ["global-slavery"]="Global Slavery Index|Índice global de esclavitud|https://www.globalslaveryindex.org"
    ["statista"]="Statista|Estadísticas de trata de personas|https://www.statista.com/topics/4238/humantrafficking"
    ["thorn-stats"]="Thorn Statistics|Estadísticas de trata infantil|https://www.thorn.org/child-trafficking-statistics"
    
    # Anti-Trafficking Organizations
    ["human-rights-first"]="Human Rights First|Organización de derechos humanos|https://www.humanrightsfirst.org"
    ["human-trafficking-center"]="Human Trafficking Center|Centro de investigación|http://humantraffickingcenter.org"
    ["ihttf"]="International Human Trafficking|Foro internacional|http://www.ihttf.com"
    ["labor-rights"]="International Labor Rights|Foro de derechos laborales|https://www.laborrights.org"
    ["la-strada"]="La Strada International|Red contra la trata|http://lastradainternational.org"
    ["not-for-sale"]="Not for Sale Campaign|Campaña contra la trata|https://www.notforsalecampaign.org"
    ["polaris"]="Polaris Project|Proyecto contra la trata|https://polarisproject.org/human-trafficking"
    ["shared-hope"]="Shared Hope International|Organización contra la trata|https://sharedhope.org/the-problem"
    
    # Government Resources
    ["interpol"]="Interpol Human Trafficking|Recursos de Interpol|https://www.interpol.int/en/Crimes/Human-trafficking"
    ["us-dod"]="US Department of Defense|Combate a la trata|http://ctip.defense.gov"
    ["us-doj"]="US Department of Justice|Sección de explotación infantil|https://www.justice.gov/criminal-ceos"
    ["us-state"]="US Department of State|Oficina de monitoreo|https://www.state.gov/bureaus-offices/undersecretary-for-civilian-security-democracy-and-humanrights/office-to-monitor-and-combat-trafficking-inpersons"
    ["usaid"]="USAID|Agencia de desarrollo|https://www.usaid.gov/trafficking"
    
    # Support and Resources
    ["national-hotline"]="National Human Trafficking|Línea directa nacional|https://humantraffickinghotline.org"
    ["runaway-safeline"]="National Runaway Safeline|Línea de ayuda|https://www.1800runaway.org"
    ["ref-world"]="Ref World|Base de datos de refugiados|http://www.refworld.org/cgi-bin/texis/vtx/rwmain"
    ["mtv-staying"]="MTV Staying Alive|Prevención y educación|http://www.mtvstayingalive.org"
    
    # Regional Resources
    ["kahtc"]="Kalamazoo Anti-Human|Centro local contra la trata|http://www.kahtc.org"
    ["maryland"]="Maryland Human Trafficking|Recursos de Maryland|http://www.mdhumantrafficking.org"
    ["modern-slavery"]="Global Modern Slavery|Directorio global|http://www.globalmodernslavery.org"
)

declare -A conflict_monitoring_tools=(
    # Global Conflict Monitoring
    ["acled"]="ACLED|Base de datos de conflictos armados|https://acleddata.com/#/dashboard"
    ["global-incident"]="Global Incident Map|Mapa de amenazas globales|http://www.globalincidentmap.com/threatmatrix.php"
    ["liveuamap"]="Liveuamap|Mapa en tiempo real de conflictos|https://liveuamap.com"
    ["rsoe"]="Emergency and Disaster Information|Servicio de información de emergencias|http://hisz.rsoe.hu"
    
    # Government Travel Advisories
    ["gov-uk"]="GOV.UK Travel Advice|Consejos de viaje del Reino Unido|https://www.gov.uk/foreign-travel-advice"
    ["state-department"]="US State Department|Información de países|https://www.state.gov/countries-areas"
    ["travel-advisory"]="US Travel Advisory Map|Mapa de advertencias de viaje|https://travelmaps.state.gov/TSGMap"
    
    # Security and Crime Monitoring
    ["numbeo"]="Numbeo Crime|Estadísticas de criminalidad|https://www.numbeo.com/crime"
    ["samdesk"]="SamDesk|Alertas de crisis en tiempo real|https://www.samdesk.io"
    ["water-peace"]="Water Peace Security|Mapa de alertas de seguridad|https://waterpeacesecurity.org/map"
    
    # Regional Monitoring
    ["act-incident"]="ACT Incident Map|Mapa de incidentes en Australia|https://esa.act.gov.au/?fullmap=true"
    
    # Digital Security
    ["encryption-map"]="World Map of Encryption|Leyes y políticas de encriptación|https://www.gp-digital.org/world-map-of-encryption"
)

declare -A terrorism_monitoring_tools=(
    # Global Terrorism Databases
    ["gtd"]="Global Terrorism Database|Base de datos global de terrorismo|https://www.start.umd.edu/gtd"
    ["tracking-terrorism"]="Tracking Terrorism|Seguimiento de incidentes terroristas|https://www.trackingterrorism.org"
    ["terrorist-attacks"]="Terrorist Attacks Map|Mapa de ataques terroristas|https://storymaps.arcgis.com/stories/dcbb5c9e009442b99944bd1ef6158bda"
    ["hate-map"]="SPLC Hate Map|Mapa de grupos de odio|https://www.splcenter.org/hate-map"
    
    # Research Centers
    ["ict"]="IDC HERZLIYA|Centro Internacional de Contraterrorismo|http://www.ict.org.il"
    ["icct"]="International Center for Counter-terrorism|Centro Internacional|https://icct.nl"
    ["icsr"]="International Centre for Radicalisation|Centro de estudio de radicalización|https://icsr.info"
    ["icsve"]="International Center for Violent Extremism|Centro de estudio de extremismo|https://www.icsve.org"
    ["cstpv"]="Handa Centre|Centro de estudio de terrorismo|https://cstpv.wp.st-andrews.ac.uk"
    
    # Government and International Organizations
    ["un-counterterrorism"]="UN Office of CounterTerrorism|Oficina de la ONU|https://www.un.org/counterterrorism"
    ["un-ctc"]="UN Security Council CTC|Comité contra el terrorismo|https://www.un.org/sc/ctc"
    ["gctf"]="Global Counterterrorism|Foro global|https://www.thegctf.org"
    ["coedat"]="COE-DAT|Base de datos de la OTAN|http://www.coedat.nato.int"
    
    # Regional Monitoring
    ["satp"]="South Asia Terrorism Portal|Portal de terrorismo en Asia|http://www.satp.org"
    ["searcct"]="Southeast Asia Centre|Centro regional contra terrorismo|https://www.searcct.gov.my"
    ["eye-isis"]="Eye on ISIS in Libya|Monitoreo de ISIS en Libia|https://eyeonisisinlibya.com"
    ["isis-map"]="ISIS Liveumap|Mapa de actividades de ISIS|https://isis.liveuamap.com"
    
    # Research and Analysis
    ["rand"]="RAND Counterterrorism|Investigación sobre contraterrorismo|https://www.rand.org/topics/counterterrorism.html"
    ["memri"]="MEMRI|Investigación de medios|https://www.memri.org"
    ["ipt"]="Investigative Project|Proyecto de investigación|http://www.investigativeproject.org"
    ["afpc"]="World Almanac of Islamism|Almanaque mundial|http://almanac.afpc.org"
    
    # Academic Resources
    ["gwu"]="GW Program on Extremism|Programa de estudio de extremismo|https://extremism.gwu.edu"
    ["str"]="Society for Terrorism Research|Sociedad de investigación|https://www.societyforterrorismresearch.org"
    ["tcths"]="Triangle Center|Centro de estudio de terrorismo|https://sites.duke.edu/tcths"
    ["teaching-terror"]="Teaching about Terrorism|Recursos educativos|http://www.teachingterror.com"
    
    # Online Monitoring
    ["terror-monitor"]="Terror Monitor|Seguimiento en Twitter|https://twitter.com/Terror_Monitor"
    ["jihadology"]="Jihadology|Estudio de yihad|https://jihadology.net"
    ["jihadica"]="Jihadica|Análisis de yihad|http://www.jihadica.com"
    ["jihad-intel"]="Jihad Intel|Inteligencia sobre yihad|https://jihadintel.meforum.org"
)

declare -A darkweb_monitoring_tools=(
    # Search Engines and Directories
    ["ahmia"]="Ahmia|Motor de búsqueda de servicios ocultos|https://ahmia.fi"
    ["dark-fail"]="Dark.fail|Directorio de servicios ocultos|https://dark.fail"
    ["hidden-wiki"]="The Hidden Wiki|Directorio de servicios ocultos|https://thehiddenwiki.org"
    ["tor-hidden-wiki"]="Tor Hidden Wiki|Directorio de servicios ocultos|https://torhiddenwiki.com"
    ["onion-search"]="Onion Search Engine|Motor de búsqueda de servicios ocultos|https://onionsearchengine.com/"
    
    # Monitoring and Analysis Tools
    ["dark-owl"]="Dark Owl|Monitoreo de dark web|https://www.darkowl.com"
    ["dark-scrape"]="Dark Scrape|Herramienta de scraping|https://github.com/itsmehacker/DarkScrape"
    ["tor-bot"]="TorBot|Herramienta OSINT|https://github.com/DedSecInside/TorBot"
    ["darkweb-scraper"]="Dark Web Scraper|Herramienta de scraping|https://apify.com/epcsht/darkweb-scraper"
    ["freshonions"]="FreshOnions|Scraper de servicios ocultos|https://github.com/dirtyfilthy/freshonions-torscraper"
    
    # Tor Tools and Services
    ["tor-project"]="Tor Project|Proyecto oficial de Tor|https://www.torproject.org"
    ["tails"]="Tails|Sistema operativo seguro|https://tails.boum.org"
    ["onionshare"]="OnionShare|Compartición segura de archivos|https://onionshare.org"
    ["tor2web"]="Tor2Web|Acceso a servicios ocultos|https://www.tor2web.org"
    ["tor-nodes"]="Tor Node List|Lista de nodos Tor|https://www.dan.me.uk/tornodes"
    
    # Investigation Tools
    ["iaca"]="IACA Dark Web Tools|Herramientas de investigación|https://iaca-darkweb-tools.com"
    ["hunchly"]="Hunchly's Report|Informe de servicios ocultos|https://www.hunch.ly/darkweb-osint"
    ["onionscan"]="OnionScan|Escaneo de servicios ocultos|https://onionscan.org"
    ["torcrawl"]="TorCrawl|Crawler de servicios ocultos|https://github.com/MikeMeliz/TorCrawl.py"
    
    # Community Resources
    ["reddit-deepweb"]="Reddit Deep Web|Comunidad de deep web|https://www.reddit.com/r/deepweb"
    ["reddit-onions"]="Reddit Onions|Comunidad de servicios ocultos|https://www.reddit.com/r/onions"
    ["reddit-tor"]="Reddit Tor|Comunidad de Tor|https://www.reddit.com/r/TOR"
    ["tor-stack"]="Tor Stack Exchange|Foro de preguntas y respuestas|https://tor.stackexchange.com"
    
    # Additional Tools
    ["subgraph"]="Subgraph|Sistema operativo seguro|https://subgraph.com/sgos"
    ["torchat"]="TorChat|Chat seguro|https://github.com/prof7bit/TorChat/wiki"
    ["pasta"]="Pasta|Herramienta de análisis|https://github.com/Kr0ff/Pasta"
    ["pastebin-bisque"]="Pastebin Bisque|Análisis de pastebin|https://github.com/bbbbbrie/pastebin-bisque"
)

declare -A search_engines_tools=(
    # Major Search Engines
    ["google"]="Google|Motor de búsqueda principal|https://www.google.com"
    ["bing"]="Bing|Motor de búsqueda de Microsoft|https://www.bing.com"
    ["yahoo"]="Yahoo! Search|Motor de búsqueda de Yahoo|https://search.yahoo.com"
    ["baidu"]="Baidu|Motor de búsqueda chino|https://www.baidu.com"
    ["yandex"]="Yandex|Motor de búsqueda ruso|https://yandex.com"
    
    # Privacy-Focused Search Engines
    ["duckduckgo"]="DuckDuckGo|Motor de búsqueda privado|https://duckduckgo.com"
    ["brave"]="Brave Search|Motor de búsqueda privado|https://search.brave.com"
    ["gibiru"]="Gibiru|Motor de búsqueda privado|https://gibiru.com"
    ["startpage"]="Startpage|Motor de búsqueda privado|https://www.startpage.com"
    ["qwant"]="Qwant|Motor de búsqueda privado|https://www.qwant.com"
    ["swisscows"]="Swisscows|Motor de búsqueda privado|https://swisscows.com"
    ["metager"]="MetaGer|Motor de búsqueda privado|https://metager.org"
    ["mojeek"]="Mojeek|Motor de búsqueda privado|https://www.mojeek.com"
    ["kagi"]="Kagi|Motor de búsqueda privado|https://kagi.com"
    
    # Meta Search Engines
    ["dogpile"]="Dogpile|Motor de búsqueda meta|https://www.dogpile.com"
    ["izito"]="iZito|Motor de búsqueda meta|https://www.izito.com"
    ["zapmeta"]="Zapmeta|Motor de búsqueda meta|https://www.zapmeta.com"
    ["searchall"]="SearchAll|Motor de búsqueda meta|https://www.searchall.com"
    ["myallsearch"]="MyAllSearch|Motor de búsqueda meta|https://www.myallsearch.com"
    ["100searchengines"]="100SearchEngines|Directorio de motores|https://www.100searchengines.com"
    
    # Specialized Search Engines
    ["wolfram"]="Wolfram Alpha|Motor de búsqueda computacional|https://www.wolframalpha.com"
    ["exalead"]="Exalead|Motor de búsqueda empresarial|https://www.exalead.com"
    ["entireweb"]="Entireweb|Motor de búsqueda global|https://www.entireweb.com"
    ["goofram"]="Goofram|Búsqueda Google + Wolfram|https://www.goofram.com"
    ["faganfinder"]="FaganFinder|Herramientas de búsqueda|https://www.faganfinder.com"
    ["thelookup"]="The Lookup|Búsqueda de personas|https://www.thelookup.com"
    ["carrot2"]="Carrot2|Organizador de resultados por temas|https://search.carrot2.org"
    
    # Ecological and Charitable Search Engines
    ["blue-search"]="Blue Search|Motor de búsqueda ecológico|https://www.blue-search.org"
    ["ekoru"]="Ekoru|Motor de búsqueda para océanos|https://www.ekoru.org"
    ["ecosia"]="Ecosia|Motor de búsqueda que planta árboles|https://www.ecosia.org"
    ["elliot"]="Elliot|Motor de búsqueda benéfico|https://www.elliotforwater.com"
    ["every-click"]="Every Click|Motor de búsqueda benéfico|https://www.everyclick.com"
    ["gexsi"]="Gexsi|Motor de búsqueda social|https://www.gexsi.com"
    ["givewater"]="GiveWater|Motor de búsqueda para agua potable|https://www.givewater.com"
    ["lilo"]="Lilo|Motor de búsqueda solidario|https://www.lilo.org"
    ["ocg"]="OCG|Motor de búsqueda ecológico|https://www.ocg.org"
    ["ocean-hero"]="Ocean Hero|Motor de búsqueda para océanos|https://www.oceanhero.today"
    ["rapusia"]="Rapusia|Motor de búsqueda ecológico|https://www.rapusia.org"
    ["searchscene"]="SearchScene|Motor de búsqueda benéfico|https://www.searchscene.com"
    ["youcare"]="YouCare|Motor de búsqueda benéfico|https://www.youcare.world"
    
    # Regional Search Engines
    ["naver"]="Naver|Motor de búsqueda coreano|https://www.naver.com"
    ["sogou"]="Sogou|Motor de búsqueda chino|https://www.sogou.com"
    ["you"]="YOU|Motor de búsqueda alemán|https://www.you.com"
    
    # OSINT Search Tools
    ["google-osint"]="Google OSINT|Buscador personalizado para OSINT|https://www.google.com/cse"
    ["search-colossus"]="Search Engine Colossus|Directorio de motores|http://www.searchenginecolossus.com"
    ["goodsearch"]="Goodsearch|Motor de búsqueda benéfico|https://www.goodsearch.com"
    ["etools"]="eTools|Herramientas de búsqueda|https://www.etools.com"
    ["searx"]="Searx|Motor de búsqueda privado|https://searx.space"
    ["osintgram"]="Osintgram|Herramienta OSINT para Instagram|https://github.com/Datalux/Osintgram"
    
    # Instagram Analysis Tools
    ["aware-online"]="Aware Online|Herramienta de búsqueda de Instagram|https://www.aware-online.com/osint-tools/instagram-search-tool"
    ["combin"]="Combin|Herramienta de gestión de Instagram|https://www.combin.com"
    ["comment-picker"]="Comment Picker|Selector de comentarios|https://commentpicker.com"
    ["display-purposes"]="Display Purposes|Generador de hashtags|https://displaypurposes.com"
    ["downalbum"]="DownAlbum|Descargador de álbumes|https://chrome.google.com/webstore/detail/downalbum/cgjnhhjpfcdhbhlcmmjppicjmgfkppok"
    ["engagement-calculator"]="Engagement Calculator|Calculadora de engagement|https://phlanx.com/engagement-calculator"
    ["export-comments"]="Export Comments|Exportador de comentarios|https://exportcomments.com"
    ["find-instagram-user-id"]="Find Instagram User ID|Buscador de IDs|https://codeofaninja.com/tools/find-instagram-user-id"
    ["gramfind"]="Gramfind|Buscador de Instagram|http://gramfind.com"
    ["hashtagify"]="Hashtagify|Analizador de hashtags|http://hashtagify.me"
    ["hashtags-for-likes"]="Hashtags for Likes|Generador de hashtags|https://www.hashtagsforlikes.co"
    ["helper-tools"]="Helper Tools|Herramientas para Instagram|https://chrome.google.com/webstore/detail/helper-tools-forinstagra/hcdbfckhdcpepllecbkaaojfgipnpbpb"
    ["hypeauditor"]="HypeAuditor|Analizador de influencers|https://hypeauditor.com"
    ["iconosquare"]="Iconosquare|Analizador de Instagram|http://iconosquare.com"
    ["igsuperstar"]="IGSuperStar|Herramienta de Instagram|https://igsuperstar.com"
    ["imgbunk"]="Imgbunk|Visualizador de Instagram|https://imgbunk.com"
    ["imginn"]="ImgInn|Visualizador de Instagram|https://imginn.com"
    ["in-tags"]="In Tags|Generador de etiquetas|https://play.google.com/store/apps/details?id=com.sunraylabs.socialtags"
    ["inssist"]="INSSIST|Herramienta de publicación|https://chrome.google.com/webstore/detail/inssist-post-stories-dmw/bcocdbombenodlegijagbhdjbifpiijp"
    ["instafollowers"]="InstaFollowers|Analizador de seguidores|https://www.instafollowers.co"
    ["instagram-crawler"]="Instagram Crawler|Rastreador de Instagram|https://github.com/hehpollon/Instagram-Crawler"
    ["instagram-explorer"]="Instagram Explorer|Explorador de Instagram|https://www.osintcombine.com/instagram-explorer"
    ["instagram-osint"]="Instagram OSINT|Herramienta OSINT|https://github.com/sc1341/InstagramOSINT"
    ["instagram-scraper"]="Instagram Scraper|Rastreador de Instagram|https://apify.com/jaroslavhejlek/instagram-scraper"
    ["instaloader"]="InstaLoader|Descargador de Instagram|https://github.com/instaloader/instaloader"
    ["instaloctrack"]="InstaLocTrack|Rastreador de ubicaciones|https://github.com/bernsteining/instaloctrack"
    ["instalooter"]="InstaLooter|Descargador de Instagram|https://github.com/althonos/InstaLooter"
    ["izuum"]="Izuum|Buscador de Instagram|http://izuum.com"
    ["keyhole"]="Keyhole|Analizador de hashtags|http://keyhole.co"
    ["leetags"]="Leetags|Generador de hashtags|https://www.leetags.com"
    ["metahashtags"]="MetaHashtags|Analizador de hashtags|https://metahashtags.com"
    ["minter"]="Minter.io|Analizador de Instagram|https://minter.io"
    ["noninstagram"]="NoInstagram|Herramienta OSINT|https://github.com/datvance/noinstagram"
    ["osi-ig"]="Osi.ig|Herramienta OSINT|https://github.com/th3unkn0n/osi.ig"
    ["otzberg"]="Otzberg.net|Buscador de IDs|https://www.otzberg.net/iguserid/index.php"
    ["panoramiq"]="Panoramiq|Herramienta de Instagram|https://apps.hootsuite.com/apps/panoramiq"
    ["phantom-buster"]="Phantom Buster|Automatizador de Instagram|https://phantombuster.com/phantombuster"
    ["picodash"]="Picodash|Analizador de Instagram|https://www.picodash.com"
    ["scylla"]="Scylla|Herramienta OSINT|https://github.com/josh0xA/Scylla"
    ["snoopreport"]="SnoopReport|Analizador de actividad|https://snoopreport.com"
    ["social-alerts"]="Social Alerts|Monitor de redes|https://github.com/mamoedo/social-alerts"
    ["socialinsider"]="SocialInsider|Analizador de redes|https://www.socialinsider.io"
    ["socid-extractor"]="Socid Extractor|Extractor de información|https://github.com/soxoj/socid_extractor"
    ["soig"]="SoIG|Herramienta OSINT|https://github.com/yezz123/SoIG"
    ["tailwind"]="Tailwind|Herramienta de Instagram|https://www.tailwindapp.com"
    ["thumbtube"]="ThumbTube|Descargador de fotos|https://thumbtube.com/instagram-profile-picture-downloader"
    ["trendhero"]="trendHERO|Analizador de Instagram|https://trendhero.io"
    ["webstagram"]="Webstagram|Visualizador de Instagram|https://webstagram.org"
    
    # Contact Search Tools
    ["addme-contacts"]="AddMe Contacts|Buscador de contactos|http://add-me-contacts.com"
    ["chattoday"]="ChatToday|Buscador de contactos|https://chattoday.com"
    ["kikfriender"]="KikFriender|Buscador de usuarios de Kik|https://kikfriender.com"
    ["kikusernames"]="KikUsernames|Directorio de usuarios de Kik|https://kikusernames.com"
    ["skypli"]="Skypli|Buscador de contactos|https://www.skypli.com"
    ["vedbex"]="Vedbex Email2Skype|Convertidor de email a Skype|https://www.vedbex.com/tools/email2skype"
    ["getcontact"]="GetContact|Buscador de contactos|https://www.getcontact.com"
    ["everycaller"]="EveryCaller|Buscador de números telefónicos|https://www.everycaller.com"
    ["privacystar"]="PrivacyStar|Protección de privacidad|https://privacystar.com/index.html"
    ["intelx-phone"]="IntelligenceX Phone|Búsqueda de números telefónicos|https://intelx.io/tools?tab=telephone"
    ["abc-telefonos"]="ABC Telefonos|Directorio telefónico|http://www.abctelefonos.com"
    ["addresses"]="Addresses|Directorio de direcciones|http://www.addresses.com"
    ["aeroleads"]="AeroLeads|Buscador de contactos|https://aeroleads.com"
    ["antel"]="Antel|Guía telefónica de Uruguay|https://aplicaciones.antel.com.uy/ConsultaGuia/form/consulta.xhtml"
    ["anywho"]="AnyWho|Búsqueda inversa de teléfonos|https://www.anywho.com/reverse-phone-lookup"
    ["aql-network"]="AQL Network|Búsqueda de operadoras|https://portal.aql.com/telecoms/network_lookup.php"
    ["australia-lookup"]="Australia Lookup|Directorio australiano|http://www.australialookup.com"
    ["aware-phone"]="Aware Online Phone|Herramienta de investigación|https://www.aware-online.com/osinttools/telefoonnummer-search-tool"
    ["bmobile"]="Bmobile|Directorio indio|https://bmobile.in"
    ["bt-phonebook"]="BT Phone Book|Directorio británico|https://www.thephonebook.bt.com"
    ["callapp"]="CallApp|Identificador de llamadas|https://callapp.com"
    ["callerid-service"]="CallerID Service|Servicio de identificación|https://secure.calleridservice.com"
    ["callerid-test"]="CallerID Test|Prueba de identificación|https://www.calleridtest.com"
    ["callersmart"]="CallerSmart|Identificador de llamadas|https://www.callersmart.com"
    ["carrier-lookup"]="Carrier Lookup|Búsqueda de operadoras|https://www.carrierlookup.com"
    ["cellrevealer"]="CellRevealer|Identificador de móviles|https://cellrevealer.com"
    ["checkmi"]="CheckMI|Verificador de cuentas|https://www.checkmi.info"
    ["codelook"]="CodeLook|Búsqueda de códigos|https://www.telecom-tariffs.co.uk/codelook.htm"
    ["country-codes"]="Country Calling Codes|Códigos de países|https://www.countrycallingcodes.com"
    ["cyber-checks"]="Cyber Background Checks|Verificación de antecedentes|https://www.cyberbackgroundchecks.com"
    ["data247"]="Data247|Búsqueda de datos|https://www.data247.com"
    ["deadtrap"]="DeadTrap|Herramienta OSINT|https://github.com/Chr0m0s0m3s/DeadTrap"
    ["directorio-mx"]="Directorio MX|Directorio mexicano|https://directorio.com.mx"
    ["emobile-tracker"]="Emobile Tracker|Rastreador de móviles|https://www.emobiletracker.com"
    
    # Telegram Search and Analysis Tools
    ["intelx-telegram"]="IntelligenceX Telegram|Herramienta de búsqueda en Telegram|https://intelx.io/tools?tab=telegram"
    ["google-telegram"]="Google Telegram Search|Buscador personalizado de Telegram|https://cse.google.com/cse?&cx=006368593537057042503:efxu7xprihg#gsc.tab=0"
    ["chatbottle"]="ChatBottle Telegram|Directorio de bots de Telegram|https://chatbottle.co/bots/telegram"
    ["informer"]="Informer|Herramienta de análisis de Telegram|https://github.com/paulpierre/informer"
    ["lyzem"]="Lyzem|Buscador de Telegram|https://lyzem.com"
    ["save-telegram-history"]="Save Telegram History|Herramienta para guardar historial|https://github.com/pigpagnet/save-telegram-chat-history"
    ["technisette"]="Technisette|Colección de herramientas OSINT|https://start.me/u/Z9Oamm/technisette"
    ["telegago"]="Telegago|Buscador de Telegram|https://cse.google.com/cse?q=+&cx=006368593537057042503:efxu7xprihg#gsc.tab=0&gsc.q=%20&gsc.page=1"
    ["telegramchannels"]="Telegram Channels|Directorio de canales|https://telegramchannels.me"
    ["tlgrm-channels"]="Tlgrm Channels|Directorio de canales|https://tlgrm.eu/channels"
    ["xtea"]="Xtea|Buscador de canales|https://xtea.io/ts_en.html"
    ["tdirectory"]="Telegram Directory|Directorio de Telegram|https://tdirectory.me"
    ["telegram-group"]="Telegram Group|Directorio de grupos|https://www.telegram-group.com"
    ["telegram-nearby"]="Telegram Nearby Map|Mapa de usuarios cercanos|https://github.com/tejado/telegram-nearby-map"
    ["telegram-scraper"]="Telegram Scraper|Herramienta de scraping|https://github.com/th3unkn0n/TeleGram-Scraper"
    ["telegram-history"]="Telegram History Dump|Exportador de historial|https://github.com/tvdstaaij/telegram-history-dump"
    ["telegram-osint"]="Telegram OSINT|Biblioteca OSINT|https://github.com/Postuf/telegram-osint-lib"
    ["telegram-tools"]="Telegram Tools|Herramientas de Telegram|https://telegram.im/tools/index.php"
    ["telemetr"]="Telemetr|Buscador de Telegram|https://telemetr.io"
    ["tgstat"]="Tgstat|Estadísticas de Telegram|https://tgstat.com"
    ["threat-intel"]="Threat Intelligence|Inteligencia de amenazas|https://start.me/p/rxRbpo/ti"
    
    # WhatsApp Tools
    ["checkwa"]="CheckWA|Verificador de WhatsApp|https://checkwa.online"
    ["fake-whatsapp"]="Fake WhatsApp|Generador de chats falsos|http://www.fakewhats.com/generator"
    ["whatsapp-monitor"]="WhatsApp Monitor|Monitor de WhatsApp|https://github.com/ErikTschierschke/WhatsappMonitor"
    ["whatsfoto"]="Whatsfoto|Herramienta de análisis de fotos|https://github.com/zoutepopcorn/whatsfoto"
    ["whatsanalyze"]="WhatsAnalyze|Analizador de chats|https://whatsanalyze.com"
    ["chatvisualizer"]="Chat Visualizer|Visualizador de chats|https://chatvisualizer.com"
    ["watools"]="WATools|Herramientas de WhatsApp|https://watools.io/download-profile-picture"
    ["wagscraper"]="WAGScraper|Scraper de grupos|https://github.com/riz4d/WaGpScraper"
    
    # Blog Search Tools
    ["botw"]="Best of the Web|Directorio de blogs|https://blogs.botw.org"
    ["blogsearchengine"]="Blog Search Engine|Motor de búsqueda de blogs|https://www.blogsearchengine.com"
    ["blogsearchengine-org"]="Blog Search Engine|Motor de búsqueda de blogs|http://www.blogsearchengine.org"
    ["blog-search"]="Blog-Search|Motor de búsqueda de blogs|https://www.blog-search.com"
    ["blogarama"]="Blogarama|Directorio de blogs|https://www.blogarama.com"
    ["bloggernity"]="Bloggernity|Directorio de blogs|http://www.bloggernity.com"
    ["bloggingfusion"]="Blogging Fusion|Directorio de blogs|https://www.bloggingfusion.com"
    ["bloghub"]="BlogHub|Directorio de blogs|http://www.bloghub.com"
    ["searchblogspot"]="Blogspot Search|Buscador de blogs Blogspot|https://www.searchblogspot.com"
    ["notey"]="Notey|Motor de búsqueda de blogs|http://www.notey.com"
    ["twingly"]="Twingly|Motor de búsqueda de blogs|http://www.twingly.com"
    ["webhose"]="Webhose|Motor de búsqueda de blogs|https://webhose.io"
    ["wordpress-search"]="WordPress Search|Buscador de blogs WordPress|https://en.search.wordpress.com"
    
    # Forum and Group Search Tools
    ["chatter"]="Chatter|Herramienta de análisis de foros|https://github.com/visualbasic6/chatter"
    ["craigslist-forums"]="Craigslist Forums|Foros de Craigslist|https://forums.craigslist.org"
    ["createaforum"]="Create a Forum|Directorio de foros|https://www.createaforum.com/directory.php"
    ["delphiforums"]="Delphi Forums|Plataforma de foros|http://www.delphiforums.com"
    ["discourse"]="Discourse|Plataforma de foros|https://www.discourse.org"
    ["facebook-groups"]="Facebook Groups|Grupos de Facebook|https://www.facebook.com"
    ["proboards-directory"]="ProBoards Directory|Directorio de foros|https://www.proboards.com/forum-directory"
    ["google-groups"]="Google Groups|Grupos de Google|https://groups.google.com"
    ["findaforum"]="Find a Forum|Buscador de foros|https://www.findaforum.net"
    ["groups-io"]="Groups.io|Plataforma de grupos|https://groups.io"
    ["linkedin-groups"]="LinkedIn Groups|Grupos de LinkedIn|http://www.linkedin.com"
    ["ning"]="Ning|Plataforma de redes sociales|http://www.ning.com"
    ["nzbindex"]="NZBIndex|Índice de grupos de noticias|https://www.nzbindex.com/groups"
    ["omgili"]="Omgili|Buscador de foros|http://omgili.com"
    ["proboards"]="ProBoards|Plataforma de foros|https://www.proboards.com"
    ["qresearch"]="QResearch|Foro de investigación|https://qresear.ch"
    ["quora"]="Quora|Plataforma de preguntas y respuestas|http://www.quora.com"
    ["ask-fm"]="Ask.fm|Plataforma de preguntas|https://ask.fm"
    ["reddit"]="Reddit|Plataforma de foros|https://www.reddit.com"
    ["slant"]="Slant.co|Plataforma de recomendaciones|https://www.slant.co"
    ["stackexchange"]="StackExchange|Red de sitios de preguntas|http://stackexchange.com"
    ["superuser"]="Super User|Foro de tecnología|https://superuser.com"
    ["answerbank"]="The Answer Bank|Plataforma de preguntas|https://www.theanswerbank.co.uk"
    ["traceanobject"]="TraceAnObject|Foro de identificación|https://www.reddit.com/r/TraceAnObject"
    ["wantoask"]="Wantoask|Plataforma de preguntas|https://www.wantoask.com"
    ["wikipedia-forums"]="Wikipedia Forums|Lista de foros de Internet|https://en.wikipedia.org/wiki/List_of_Internet_forums"
    ["wsid"]="WSID|Plataforma de preguntas|https://www.wsid.com"
    ["otvet"]="Ответы|Plataforma de preguntas rusa|https://otvet.mail.ru"
    
    # Monitoring and Alert Tools
    ["agility-pr"]="Agility PR|Monitoreo de medios|https://www.agilitypr.com"
    ["pastealert"]="PasteLert|Alertas de pastebins|https://andrewmohawk.com/pasteLert"
    ["google-alerts"]="Google Alerts|Alertas de Google|https://www.google.es/alerts"
    ["boe-alerts"]="BOE Alerts|Alertas del BOE|https://www.boe.es/mi_boe"
    ["burrelles"]="Burrelles|Monitoreo de medios|https://burrelles.com"
    ["critical-mention"]="Critical Mention|Monitoreo de medios|https://www.criticalmention.com"
    ["emediamonitor"]="eMediaMonitor|Monitoreo de medios|https://www.emediamonitor.net"
    ["ezyinsights"]="EzyInsights|Monitoreo de medios|https://ezyinsights.com"
    ["followthatpage"]="FollowThatPage|Monitor de cambios web|https://www.followthatpage.com"
    ["google-trends"]="Google Trends|Tendencias de búsqueda|https://trends.google.es/trends"
    ["hootsuite"]="Hootsuite|Gestión de redes sociales|https://hootsuite.com/es"
    ["iq-media"]="IQ.Media|Monitoreo de medios|http://www.iq.media"
    ["isentia"]="Isentia|Monitoreo de medios|https://www.isentia.com"
    ["lexis-nexis"]="LexisNexis Newsdesk|Monitoreo de noticias|https://www.lexisnexis.com/enus/products/newsdesk.page"
    ["mailist"]="Mailist|Monitoreo de correos|https://mailist.app"
    ["media-monitors"]="Media Monitors|Monitoreo de medios|https://www.mediamonitors.com"
    ["meltwater"]="Meltwater|Monitoreo de medios|https://www.meltwater.com"
    ["metromonitor"]="MetroMonitor|Monitoreo de medios|https://metromonitor.com"
    ["muck-rack"]="Muck Rack|Monitoreo de medios|https://muckrack.com"
    ["news-exposure"]="News Exposure|Monitoreo de medios|https://www.newsexposure.com"
    ["newsbox"]="NewsBox|Monitoreo de medios|https://newsbox.com"
    ["newspoint"]="Newspoint|Monitoreo de medios|https://www.newspoint.pl/en"
    ["sail-labs"]="SAIL Labs|Monitoreo de medios|https://www.sail-labs.com"
    ["signal-ai"]="Signal AI|Monitoreo de medios|https://www.signal-ai.com"
    ["tveyes"]="TVEyes|Monitoreo de televisión|https://tveyes.com"
    ["social-searcher"]="Social Searcher|Monitor de redes sociales|https://www.social-searcher.com"
    ["tagcrowd"]="TagCrowd|Generador de nubes de etiquetas|https://tagcrowd.com"
    ["talkwalker"]="Talkwalker|Servicio de alertas|https://www.talkwalker.com/alerts"
    ["thevisualized"]="TheVisualized|Tendencias en redes sociales|https://thevisualized.com"
    ["tweetdeck"]="TweetDeck|Gestor de Twitter|https://tweetdeck.twitter.com"
    ["visualping"]="VisualPing|Monitor de cambios web|https://visualping.io"
    ["darkweb-hunchly"]="DarkWeb Hunchly|Monitoreo de dark web|https://darkweb.hunch.ly"
    
    # IRC and XDCC Search Tools
    ["netsplit"]="Netsplit IRC|Buscador de canales IRC|https://netsplit.de/channels"
    ["kiwiirc"]="KiwiIRC Search|Buscador de canales IRC|https://kiwiirc.com/search"
    ["mibbit"]="Mibbit Search|Buscador de canales IRC|https://search.mibbit.com"
    ["sunxdcc"]="SunXDCC|Buscador de archivos XDCC|https://sunxdcc.com"
    ["xdcc-eu"]="XDCC.eu|Buscador de archivos XDCC|https://www.xdcc.eu"
    
    # Legacy Search Engines
    ["aol"]="AOL Search|Motor de búsqueda de AOL|https://search.aol.com"
    ["ask"]="Ask.com|Motor de búsqueda de preguntas|https://www.ask.com"
    ["lycos"]="Lycos|Motor de búsqueda histórico|https://www.lycos.com"
    ["infospace"]="InfoSpace|Motor de búsqueda meta|https://www.infospace.com"
    ["excite"]="Excite|Motor de búsqueda histórico|https://www.excite.com"
    ["webcrawler"]="WebCrawler|Motor de búsqueda histórico|https://www.webcrawler.com"
    ["yippy"]="Yippy|Motor de búsqueda histórico|https://www.yippy.com"
    
    # Additional Tools
    ["mywebsearch"]="MyWebSearch|Motor de búsqueda personalizado|https://www.mywebsearch.com"
    ["search-com"]="Search.com|Motor de búsqueda meta|https://www.search.com"
    ["searchit"]="Search It|Motor de búsqueda meta|https://www.searchit.com"
    ["sonicrun"]="SonicRun|Motor de búsqueda meta|https://www.sonicrun.com"
    ["bing-vs-google"]="Bing vs. Google|Comparador de motores|https://www.bing-vs-google.com"
    # SMS and Temporary Number Tools
    ["7sim"]="7Sim|Servicio de números temporales|http://7sim.net"
    ["freeonlinephone"]="Free Online Phone|Servicio de números temporales|https://www.freeonlinephone.org"
    ["freephonenum"]="Free Phone Num|Servicio de números temporales|https://freephonenum.com"
    ["getfreesms"]="Get Free SMS|Servicio de SMS temporales|https://getfreesmsnumber.com"
    ["hs3x"]="Number Hs3x|Servicio de números temporales|https://hs3x.com"
    ["mytrashmobile"]="My Trash Mobile|Servicio de números temporales|https://www.mytrashmobile.com"
    ["onlinesim"]="Online SIM|Servicio de números temporales|https://onlinesim.ru"
    ["proovl"]="Proovl|Servicio de números temporales|https://www.proovl.com"
    ["receiveasms"]="Receive a SMS|Servicio de SMS temporales|https://www.receiveasms.com"
    ["receivefreesms"]="Receive Free SMS|Servicio de SMS temporales|http://receivefreesms.com"
    ["receivesms"]="Receive SMS|Servicio de SMS temporales|https://www.receivesms.co"
    ["receive-sms"]="Receive SMS|Servicio de SMS temporales|https://receive-sms.com"
    ["receive-smss"]="Receive SMS Online|Servicio de SMS temporales|https://receive-smss.com"
    ["receive-sms-online"]="Receive SMS Online.info|Servicio de SMS temporales|http://receive-sms-online.info"
    ["receivesmsonline"]="Receive SMS Online|Servicio de SMS temporales|https://www.receivesmsonline.net"
    ["smsfinders"]="SMS Finders|Servicio de SMS temporales|https://smsfinders.com"
    ["sms-receive"]="SMS Receive|Servicio de SMS temporales|https://sms-receive.net"
    ["sms-sellaite"]="SMS Sellaite|Servicio de SMS temporales|http://sms.sellaite.com"
    ["spoofbox"]="Spoof Box|Servicio de números temporales|https://www.spoofbox.com/en/tool/trash-mobile"
    ["textverified"]="Text Verified|Servicio de verificación por SMS|https://www.textverified.com"
    # User Search Tools
    ["socialcatfish"]="SocialCatfish|Buscador de usuarios en redes sociales|https://socialcatfish.com"
    ["busquedadeusuarios"]="Búsqueda de Usuarios|Buscador de usuarios en redes sociales|https://búsquedadeusuarios.org"
    ["peekyou"]="PeekYou|Buscador de usuarios en redes sociales|https://peekyou.com"
    ["instantusername"]="InstantUsername|Buscador de nombres de usuario|https://instantusername.com"
    ["namechk"]="Namechk|Verificador de nombres de usuario|https://namechk.com"
    ["blackbird"]="Blackbird|Herramienta OSINT para enumeración de nombres de usuario en 581 sitios|https://github.com/p1ngul1n0/blackbird|https://blackbird-osint.herokuapp.com"
)

declare -A email_tools=(
    # Email Management and Organization
    ["activeinbox"]="ActiveInbox|Gestiona tu bandeja de entrada|http://www.activeinboxhq.com"
    ["batchedinbox"]="Batched Inbox|Organizador de correos|https://www.batchedinbox.com"
    ["boomerang"]="Boomerang for Gmail|Gestión avanzada de Gmail|http://www.boomeranggmail.com"
    ["cleanfox"]="Cleanfox|Limpieza de bandeja de entrada|https://www.cleanfox.io"
    ["clearcontext"]="ClearContext|Organizador de correos|http://www.clearcontext.com"
    ["followupthen"]="FollowUpThen|Recordatorios por email|https://www.followupthen.com"
    ["hiver"]="Hiver|Gestión colaborativa de Gmail|http://hiverhq.com"
    ["integrated-gmail"]="Integrated Gmail|Extensión para Gmail|https://addons.mozilla.org/en-US/firefox/addon/integrated-gmail"
    ["mailstore"]="Mailstore|Archivo de correos|http://www.mailstore.com"
    ["nudgemail"]="NudgeMail|Recordatorios por email|https://www.nudgemail.com"
    ["sanebox"]="Sanebox|Organizador de correos|https://www.sanebox.com"
    ["sortd"]="Sortd|Organizador de correos|http://www.sortd.com"
    ["subscription-zero"]="Subscription Zero|Gestión de suscripciones|https://subscriptionzero.com"
    ["wisestamp"]="WiseStamp|Firma de correos|https://www.wisestamp.com"
    
    # Email Verification and Analysis
    ["analyzeid"]="AnalyzeID|Búsqueda inversa de emails|http://analyzeid.com/"
    ["anymailfinder"]="AnyMailFinder|Buscador de emails verificados|https://anymailfinder.com/"
    ["avatarapi"]="Avatar API|API de avatares|https://avatarapi.com/"
    ["buster"]="Buster|Reconocimiento de emails|https://github.com/sham00n/buster"
    ["castrickclues"]="CastrickClues|Análisis de emails|https://castrickclues.com/"
    ["emailrep"]="EmailRep|Verificación de reputación|https://emailrep.io/"
    ["email-validator"]="Email Validator|Validador de emails|http://www.email-validator.net/"
    ["emailfinder"]="Email Finder|Buscador de emails|https://github.com/Josue87/EmailFinder"
    ["email-format"]="Email Format|Formato de emails|http://email-format.com/"
    ["email-permutator"]="Email Permutator|Generador de emails|https://docs.google.com/spreadsheets/d/17URMtNmXfEZEW9oUL_taLpGaqTDcMkA79J8TRw4xnz8/edit#gid=0"
    ["emailanalyzer"]="EmailAnalyzer|Analizador de emails|https://github.com/keraattin/EmailAnalyzer"
    ["emailhippo"]="EmailHippo|Verificador de emails|https://tools.emailhippo.com/email/"
    ["emailsherlock"]="EmailSherlock|Buscador de emails|https://www.emailsherlock.com/"
    ["eo-ripper"]="EO-Ripper|OSINT para emails|https://github.com/Quantika14/email-osint-ripper"
    ["epieos"]="Epieos|Análisis de emails|https://epieos.com/"
    ["eyes"]="Eyes|Herramienta OSINT de emails|https://github.com/N0rz3/Eyes"
    ["geemail"]="geeMail User Finder|Buscador de usuarios|https://github.com/dievus/geeMailUserFinder"
    ["ghunt"]="GHunt|Investigación de Google|https://github.com/mxrch/GHunt"
    ["gravatar"]="Gravatar Check|Verificador de avatares|https://en.gravatar.com/site/check/"
    ["h8mail"]="H8mail|Buscador de emails|https://github.com/khast3x/h8mail"
    ["holehe"]="Holehe|Verificador de emails|https://github.com/megadose/holehe"
    ["hunter"]="Hunter.io|Buscador de emails|https://hunter.io/"
    ["infobyip"]="Infobyip|Verificador de emails|https://es.infobyip.com/verifyemailaccount.php"
    ["iplogger"]="IPLogger|Obtención de IPs|https://iplogger.org/"
    ["mailboxlayer"]="MailBoxLayer API|API de verificación|https://mailboxlayer.com/"
    ["mailcat"]="Mailcat|Herramienta de emails|https://github.com/sharsil/mailcat"
    ["mailfoguess"]="Mailfoguess|Adivinador de emails|https://github.com/WildSiphon/Mailfoguess"
    ["mailmeta"]="mailMeta|Metadatos de emails|https://github.com/gr33nm0nk2802/mailMeta"
    ["mailtester"]="MailTester|Verificador de emails|http://mailtester.com/"
    ["metric-sparrow"]="Metric Sparrow|Generador de emails|http://metricsparrow.com/toolkit/email-permutator/"
    ["mxtoolbox"]="MXToolbox|Herramientas de email|https://mxtoolbox.com/"
    ["mxtoolbox-headers"]="MXToolbox Headers|Analizador de cabeceras|https://mxtoolbox.com/EmailHeaders.aspx"
    ["omail"]="Omail|Buscador de leads|https://omail.io/leads/download.html"
    ["osint-industries"]="OSINT Industries|Herramientas OSINT|https://osint.industries/email"
    ["peepmail"]="Peepmail|Generador de emails|http://www.samy.pl/peepmail"
    ["phonebook"]="Phonebook|Buscador de contactos|https://phonebook.cz/"
    ["pipl"]="Pipl|Buscador de personas|https://pipl.com/"
    ["poastal"]="Poastal|Buscador de emails|https://github.com/jakecreps/poastal"
    ["prot1ntelligence"]="Prot1ntelligence|Herramienta OSINT|https://github.com/C3n7ral051nt4g3ncy/Prot1ntelligence"
    ["psbdmp"]="Psbdmp|Buscador de datos comprometidos|https://psbdmp.ws/"
    ["reacher"]="Reacher|Verificador de emails|https://reacher.email/"
    ["rocketreach"]="Rocketreach|Buscador de contactos|https://rocketreach.co/"
    ["signalhire"]="Signalhire|Buscador de contactos|https://www.signalhire.com/"
    ["skymem"]="Skymem|Buscador de emails|https://www.skymem.info/"
    ["snov"]="Snov.io|Buscador de emails|https://snov.io/"
    ["spycloud"]="SpyCloud|Buscador de datos comprometidos|https://spycloud.com/"
    ["spycloud-check"]="SpyCloud Check|Verificador de exposición|https://spycloud.com/check-your-exposure/"
    ["thatsthem"]="ThatsThem|Búsqueda inversa de emails|https://thatsthem.com/reverse-email-lookup"
    ["theharvester"]="theHarvester|Recolector de información|https://github.com/laramies/theHarvester"
    ["toofr"]="Toofr|Buscador de emails|https://www.toofr.com/"
    ["ugly-email"]="Ugly Email|Verificador de emails|https://uglyemail.com"
    ["verify-email"]="Verify Email|Verificador de emails|http://verify-email.org/"
    ["verifyemailaddress"]="VerifyEmailAddress|Verificador de emails|https://www.verifyemailaddress.org/"
    ["voilanorbert"]="VoilaNorbert|Buscador de emails|https://www.voilanorbert.com/"
    ["whatmail"]="What Mail?|Verificador de emails|https://github.com/z0m31en7/WhatMail"
    ["whoismind"]="Whoismind|Búsqueda inversa|http://www.whoismind.com/"
    ["whoreadme"]="Whoreadme|Obtención de IPs|http://whoreadme.com/"
    ["whoxy"]="Whoxy|Búsqueda inversa|https://www.whoxy.com/reverse-whois/"
    ["zehef"]="ZEHEF|Herramienta OSINT|https://github.com/N0rz3/Zehef"
)

declare -A network_scanning_tools=(
    ["nmap"]="Nmap|Herramienta de escaneo de red gratuita y de código abierto|https://nmap.org"
    ["angry-ip-scanner"]="Angry IP Scanner|Escáner de direcciones IP gratuito y de código abierto|https://angryip.org"
    ["zenmap"]="Zenmap|Interfaz GUI de Nmap gratuita y de código abierto|https://nmap.org/zenmap"
    ["advanced-ip-scanner"]="Advanced IP Scanner|Herramienta gratuita de escaneo de IP|https://www.advanced-ip-scanner.com"
    ["fping"]="Fping|Herramienta de ping gratuita y de código abierto|https://fping.org"
    ["superscan"]="SuperScan|Escáner de puertos multifuncional gratuito|https://www.mcafee.com/enterprise/en-us/downloads/free-tools/superscan.html"
    ["unicornscan"]="Unicornscan|Escáner de puertos TCP y UDP gratuito|https://github.com/dneufeld/unicornscan"
    ["netcat"]="Netcat|Herramienta de utilidad de red gratuita|https://netcat.sourceforge.net"
    ["netscantools"]="NetScanTools|Conjunto de herramientas de diagnóstico de red|https://www.netscantools.com"
    ["nessus"]="Nessus|Escáner de vulnerabilidades pago|https://www.tenable.com/products/nessus"
)

declare -A vulnerability_scanning_tools=(
    ["openvas"]="OpenVAS|Escáner de vulnerabilidades gratuito y de código abierto|https://www.openvas.org"
    ["acunetix"]="Acunetix|Escáner de vulnerabilidades de aplicaciones web|https://www.acunetix.com"
    ["qualys"]="Qualys Cloud Platform|Plataforma de gestión de vulnerabilidades|https://www.qualys.com"
    ["nexpose"]="Nexpose|Escáner de vulnerabilidades local|https://www.rapid7.com/products/nexpose"
    ["saint"]="SAINT Security Suite|Escáner de seguridad y herramienta de prueba de penetración|https://www.saintcorporation.com"
    ["nikto"]="Nikto|Escáner y probador de servidores web|https://cirt.net/Nikto2"
    ["gfi-languard"]="GFI LanGuard|Herramienta y escáner de seguridad de red|https://www.gfi.com/products-and-solutions/network-security-solutions/gfi-languard"
)

declare -A password_cracking_tools=(
    ["john"]="John the Ripper|Herramienta para descifrar contraseñas|https://www.openwall.com/john"
    ["hashcat"]="Hashcat|Herramienta avanzada de recuperación de contraseñas|https://hashcat.net"
    ["cain"]="Cain and Abel|Herramienta de recuperación de contraseñas|https://www.oxid.it/cain.html"
    ["rainbowcrack"]="RainbowCrack|Herramienta para descifrar hash|https://project-rainbowcrack.com"
    ["aircrack-ng"]="Aircrack-ng|Conjunto de herramientas de seguridad de redes Wi-Fi|https://www.aircrack-ng.org"
    ["hydra"]="Hydra|Herramienta para descifrar el inicio de sesión en red|https://github.com/vanhauser-thc/thc-hydra"
    ["thc-hydra"]="THC Hydra|Herramienta para descifrar contraseñas|https://github.com/vanhauser-thc/thc-hydra"
    ["medusa"]="Medusa|Herramienta para descifrar contraseñas|https://github.com/jmk-foofus/medusa"
    ["l0phtcrack"]="L0phtCrack|Herramienta de recuperación y auditoría de contraseñas|https://www.l0phtcrack.com"
)

declare -A exploitation_tools=(
    ["metasploit"]="Metasploit|Marco de pruebas de penetración|https://www.metasploit.com"
    ["burpsuite"]="Burp Suite|Herramienta de prueba de seguridad de aplicaciones web|https://portswigger.net/burp"
    ["canvas"]="Canvas|Herramienta de evaluación de vulnerabilidades|https://www.immunityinc.com/products/canvas"
    ["core-impact"]="Core Impact|Herramienta de evaluación de vulnerabilidades|https://www.coresecurity.com/core-impact"
    ["set"]="Social-Engineer Toolkit|Marco de pruebas de penetración|https://github.com/trustedsec/social-engineer-toolkit"
    ["beef"]="BeEF|Herramienta de prueba de penetración|https://beefproject.com"
    ["powersploit"]="PowerSploit|Marco de pruebas de penetración|https://github.com/PowerShellMafia/PowerSploit"
    ["sqlmap"]="SQLMap|Herramienta de prueba de vulnerabilidad|https://sqlmap.org"
    ["armitage"]="Armitage|Herramienta gráfica de gestión de ciberataques|https://www.fastandeasyhacking.com"
    ["zap"]="Zed Attack Proxy|Herramienta de prueba de seguridad|https://www.zaproxy.org"
)

declare -A packet_sniffing_tools=(
    ["wireshark"]="Wireshark|Herramienta de captura de paquetes|https://www.wireshark.org"
    ["tcpdump"]="Tcpdump|Analizador de paquetes de red|https://www.tcpdump.org"
    ["ettercap"]="Ettercap|Conjunto para ataques de intermediario|https://www.ettercap-project.org"
    ["bettercap"]="Bettercap|Herramienta para ataques a la red|https://www.bettercap.org"
    ["snort"]="Snort|Sistema de prevención y detección de intrusiones|https://www.snort.org"
    ["ngrep"]="Ngrep|Analizador de paquetes de red|https://github.com/jpr5/ngrep"
    ["networkminer"]="NetworkMiner|Herramienta de análisis forense|https://www.netresec.com"
    ["hping3"]="Hping3|Herramienta de análisis de paquetes|https://github.com/antirez/hping"
    ["nemesis"]="Nemesis|Herramienta para la creación e inyección de paquetes|https://github.com/libnet/nemesis"
)

declare -A wireless_hacking_tools=(
    ["wifite"]="Wifite|Herramienta de auditoría de redes inalámbricas|https://github.com/derv82/wifite2"
    ["kismet"]="Kismet|Detector y rastreador de red inalámbrica|https://www.kismetwireless.net"
    ["reaver"]="Reaver|Herramienta de ataque de fuerza bruta para WPS|https://github.com/t6x/reaver-wps-fork-t6x"
    ["fern-wifi"]="Fern Wi-Fi Cracker|Herramienta de ataque inalámbrica|https://github.com/savio-code/fern-wifi-cracker"
    ["bully"]="Bully|Herramienta de ataque de fuerza bruta WPS|https://github.com/aanarchyy/bully"
    ["cowpatty"]="CoWPAtty|Herramienta para descifrar contraseñas WPA2-PSK|https://github.com/joswr1ght/cowpatty"
    ["inssider"]="InSSIDer|Herramienta de escaneo de redes Wi-Fi|https://www.metageek.com/products/inssider"
)

declare -A web_app_hacking_tools=(
    ["skipfish"]="Skipfish|Herramienta de reconocimiento de seguridad|https://code.google.com/archive/p/skipfish"
    ["grendel-scan"]="Grendel-Scan|Herramienta de escaneo de aplicaciones web|https://sourceforge.net/projects/grendel"
    ["vega"]="Vega|Plataforma de prueba de vulnerabilidades web|https://subgraph.com/vega"
    ["webscarab"]="WebScarab|Herramienta de prueba de vulnerabilidades|https://www.owasp.org/index.php/Category:OWASP_WebScarab_Project"
    ["ironwasp"]="IronWASP|Plataforma de prueba de seguridad|https://ironwasp.org"
)

declare -A forensics_tools=(
    ["encase"]="EnCase|Software para análisis forense digital|https://www.guidancesoftware.com"
    ["autopsy"]="Autopsy|Plataforma forense digital|https://www.autopsy.com"
    ["sift"]="SIFT|Conjunto de herramientas para análisis forense|https://digital-forensics.sans.org/community/downloads"
    ["ftk"]="FTK|Software de investigación forense|https://accessdata.com/products-services/forensic-toolkit-ftk"
    ["x-ways"]="X-Ways Forensics|Software forense|https://www.x-ways.net/forensics"
    ["helix3"]="Helix3 Pro|Respuesta a incidentes y CD forense|https://www.e-fense.com/helix3pro.php"
    ["foremost"]="Foremost|Herramienta de recuperación de archivos|https://github.com/korczis/foremost"
    ["scalpel"]="Scalpel|Grabador de archivos para análisis forense|https://github.com/sleuthkit/scalpel"
    ["sleuthkit"]="The Sleuth Kit|Biblioteca de software de investigación|https://www.sleuthkit.org"
    ["caine"]="CAINE|Entorno forense digital|https://www.caine-live.net"
)

declare -A social_engineering_tools=(
    ["king-phisher"]="King Phisher|Conjunto de herramientas de campaña de phishing|https://github.com/securestate/king-phisher"
    ["maltego"]="Maltego|Herramienta de análisis de enlaces y OSINT|https://www.maltego.com"
    ["wifiphisher"]="Wifiphisher|Marco de punto de acceso fraudulento|https://github.com/wifiphisher/wifiphisher"
    ["reelphish"]="ReelPhish|Herramienta para phishing con autenticación de dos factores|https://github.com/fireeye/ReelPhish"
    ["evilginx"]="Evilginx|Marco de ataque de intermediario|https://github.com/kgretzky/evilginx2"
    ["ghost-phisher"]="Ghost Phisher|Herramienta de phishing inalámbrica|https://github.com/savio-code/ghost-phisher"
    ["gophish"]="GoPhish|Conjunto de herramientas de phishing|https://getgophish.com"
    ["credential-harvester"]="Credential Harvester|Herramienta para robo de credenciales|https://github.com/trustedsec/social-engineer-toolkit"
)

declare -A miscellaneous_tools=(
    ["openssl"]="OpenSSL|Conjunto de herramientas de seguridad|https://www.openssl.org"
    ["pcredz"]="Pcredz|Herramienta para extraer credenciales|https://github.com/lgandx/PCredz"
    ["mimikatz"]="Mimikatz|Herramienta para extraer credenciales|https://github.com/gentilkiwi/mimikatz"
    ["sysinternals"]="Sysinternals Suite|Colección de utilidades del sistema|https://docs.microsoft.com/en-us/sysinternals"
)

# Tool Execution
run_tool() {
    local category=$1
    local tool_name=$2
    local tool_dir="$TOOLS_DIR/$category/$tool_name"
    
    # Check if tool exists
    if [ ! -d "$tool_dir" ]; then
        echo -e "${YELLOW}${WARNING} Herramienta no instalada. Instalando...${NC}"
        install_tool "$category" "$tool_name"
    fi
    
    # Verify tool integrity
    verify_tool_installation "$tool_dir" "$tool_name" || return 1
    
    # Show tool banner
    show_tool_banner "$tool_name" "latest" "$category"
    
    # Execute tool based on category and name
    case "$category" in
        "exploitation")
            case "$tool_name" in
                "metasploit")
                    cd "$tool_dir" && ./msfconsole ;;
                "sqlmap")
                    cd "$tool_dir" && python3 sqlmap.py ;;
                "beef")
                    cd "$tool_dir" && ./beef ;;
                "empire")
                    cd "$tool_dir" && ./empire ;;
                "koadic")
                    cd "$tool_dir" && python3 koadic ;;
            esac
            ;;
        "network")
            case "$tool_name" in
                "wireshark")
                    wireshark ;;
                "nmap")
                    read -p "Objetivo (IP/rango): " target
                    nmap -sC -sV "$target" ;;
                "bettercap")
                    cd "$tool_dir" && ./bettercap ;;
                "responder")
                    cd "$tool_dir" && python3 Responder.py -I eth0 ;;
                "netcat")
                    read -p "Modo (listen/connect): " mode
                    case "$mode" in
                        "listen")
                            read -p "Puerto: " port
                            nc -lvnp "$port" ;;
                        "connect")
                            read -p "Host: " host
                            read -p "Puerto: " port
                            nc "$host" "$port" ;;
                    esac
                    ;;
            esac
            ;;
        "web")
            case "$tool_name" in
                "burpsuite")
                    burpsuite ;;
                "nikto")
                    read -p "Objetivo (URL): " target
                    cd "$tool_dir" && ./nikto.pl -h "$target" ;;
                "wpscan")
                    read -p "Objetivo (URL WordPress): " target
                    cd "$tool_dir" && ./wpscan --url "$target" ;;
                "dirbuster")
                    read -p "Objetivo (URL): " target
                    cd "$tool_dir" && java -jar DirBuster.jar -u "$target" ;;
                "sqlmap")
                    read -p "URL objetivo: " target
                    cd "$tool_dir" && python3 sqlmap.py -u "$target" ;;
            esac
            ;;
        "crypto")
            case "$tool_name" in
                "miner")
                    cd "$tool_dir" && ./miner ;;
                "wallet-cracker")
                    cd "$tool_dir" && ./wallet_cracker ;;
                "blockchain-analyzer")
                    cd "$tool_dir" && python3 blockchain_analyzer.py ;;
                "crypto-trader")
                    cd "$tool_dir" && python3 crypto_trader.py ;;
                "hash-cracker")
                    cd "$tool_dir" && ./hash_cracker ;;
            esac
            ;;
    esac
    
    echo -e "\n${YELLOW}Presione ENTER para continuar...${NC}"
    read
}

update_tools() {
    echo -e "${CYAN}${LOADING_WHEEL} Actualizando herramientas...${NC}"
    
    local total_tools=0
    local updated_tools=0
    local failed_tools=0
    
    # Count total tools
    for category in "$TOOLS_DIR"/*; do
        if [ -d "$category" ]; then
            for tool in "$category"/*; do
                if [ -d "$tool" ]; then
                    ((total_tools++))
                fi
            done
        fi
    done
    
    local current=0
    # Update each tool
    for category in "$TOOLS_DIR"/*; do
        if [ -d "$category" ]; then
            category_name=$(basename "$category")
            for tool in "$category"/*; do
                if [ -d "$tool" ]; then
                    ((current++))
                    tool_name=$(basename "$tool")
                    show_styled_progress $current $total_tools "Actualizando $tool_name"
                    
                    if (cd "$tool" && git pull --quiet); then
                        ((updated_tools++))
                    else
                        ((failed_tools++))
                        log_error "Error al actualizar $tool_name"
                    fi
                fi
            done
        fi
    done
    
    echo -e "\n${GREEN}${SUCCESS} Actualización completada${NC}"
    echo -e "${BLUE}${INFO} Total de herramientas: $total_tools${NC}"
    echo -e "${GREEN}${CHECK} Actualizadas: $updated_tools${NC}"
    echo -e "${RED}${ERROR} Fallidas: $failed_tools${NC}"
}

# Main Program Flow
main() {
    # Initialize
    show_splash_screen
    log_info "Iniciando $TOOLKIT_NAME Toolkit v$VERSION"
    
    # Check Requirements
    if ! check_system_requirements; then
        cleanup_and_exit 1
    fi
    
    # Setup
    create_directory_structure
    load_configuration
    
    # Install all tools
    install_all_tools
    
    # Main Loop
    while true; do
        show_main_menu
        read -r option
        
        case $option in
            1) show_category_menu "network" "Herramientas de Red" "${network_scanning_tools[@]}" ;;
            2) show_category_menu "vulnerability" "Herramientas de Vulnerabilidades" "${vulnerability_scanning_tools[@]}" ;;
            3) show_category_menu "password" "Herramientas de Contraseñas" "${password_cracking_tools[@]}" ;;
            4) show_category_menu "exploitation" "Herramientas de Explotación" "${exploitation_tools[@]}" ;;
            5) show_category_menu "packet" "Herramientas de Paquetes" "${packet_sniffing_tools[@]}" ;;
            6) show_category_menu "wireless" "Herramientas Inalámbricas" "${wireless_hacking_tools[@]}" ;;
            7) show_category_menu "webapp" "Herramientas Web" "${web_app_hacking_tools[@]}" ;;
            8) show_category_menu "forensics" "Herramientas Forenses" "${forensics_tools[@]}" ;;
            9) show_category_menu "social" "Herramientas de Ingeniería Social" "${social_engineering_tools[@]}" ;;
            10) show_category_menu "search" "Motores de Búsqueda" "${search_engines_tools[@]}" ;;
            11) show_category_menu "verification" "Verificación de Cuentas" "${account_verification_tools[@]}" ;;
            12) show_category_menu "financial" "Análisis Financiero" "${financial_analysis_tools[@]}" ;;
            13) show_category_menu "asset" "Seguimiento de Activos" "${asset_tracking_tools[@]}" ;;
            14) show_category_menu "human" "Derechos Humanos" "${human_rights_tools[@]}" ;;
            15) show_category_menu "conflict" "Monitoreo de Conflictos" "${conflict_monitoring_tools[@]}" ;;
            16) show_category_menu "terrorism" "Monitoreo de Terrorismo" "${terrorism_monitoring_tools[@]}" ;;
            17) show_category_menu "darkweb" "Monitoreo de Dark Web" "${darkweb_monitoring_tools[@]}" ;;
            18) show_category_menu "email" "Herramientas de Email" "${email_tools[@]}" ;;
            19) show_category_menu "misc" "Herramientas Varias" "${miscellaneous_tools[@]}" ;;
            20) handle_settings_menu ;;
            21) update_tools ;;
            22) cleanup_and_exit 0 ;;
            *)
                echo -e "${RED}${ERROR} Opción inválida${NC}"
                sleep 1
                ;;
        esac
    done
}

# Cleanup and Exit
cleanup_and_exit() {
    local exit_code=$1
    log_info "Finalizando $TOOLKIT_NAME Toolkit"
    rm -rf "$TEMP_DIR"/*
    exit "$exit_code"
}

# Start the program
main
