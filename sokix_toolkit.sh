#!/bin/bash

# SOKIX Toolkit - Professional Edition
# Version: 5.0.0
# License: MIT
# Author: SOKIX Security Team

# Enhanced strict mode with error handling
set -euo pipefail
IFS=$'\n\t'
trap 'handle_error $? $LINENO' ERR

# Global Configuration
readonly VERSION="5.0.0"
readonly TOOLKIT_NAME="SOKIX Professional"
readonly CONFIG_FILE="/etc/sokix/config.yaml"
readonly LOG_FILE="/var/log/sokix/toolkit.log"
readonly MODULES_DIR="/usr/share/sokix/modules"
readonly PLUGINS_DIR="/usr/share/sokix/plugins"
readonly SCRIPTS_DIR="/usr/share/sokix/scripts"
readonly CACHE_DIR="/var/cache/sokix"
readonly TEMP_DIR="/tmp/sokix"
readonly BACKUP_DIR="/var/backups/sokix"
readonly REPORTS_DIR="/var/reports/sokix"
readonly LOCK_FILE="/var/lock/sokix.lock"
readonly DIAGNOSTIC_FILE="/var/log/sokix/diagnostic.log"
readonly PERFORMANCE_FILE="/var/log/sokix/performance.log"

# System Requirements
readonly MIN_RAM_MB=8192
readonly MIN_DISK_GB=100
readonly MIN_CPU_CORES=8
readonly REQUIRED_COMMANDS=(
    "git" "curl" "wget" "python3" "pip3" "awk" "sed" "grep" 
    "tar" "unzip" "gcc" "make" "docker" "virtualenv" "npm"
    "jq" "yq" "ansible" "terraform" "kubectl" "helm"
    "go" "rustc" "cargo" "node" "npm" "yarn"
    "perf" "strace" "ltrace" "gdb" "valgrind" "htop"
    "iostat" "vmstat" "netstat" "ss" "tcpdump" "wireshark"
    "nmap" "masscan" "zmap" "metasploit" "sqlmap" "burpsuite"
    "gobuster" "dirb" "nikto" "wpscan" "joomscan" "droopescan"
    "hydra" "john" "hashcat" "aircrack-ng" "reaver" "wifite"
    "theharvester" "maltego" "spiderfoot" "recon-ng" "sherlock"
    "autopsy" "volatility" "binwalk" "foremost" "scalpel"
    "radare2" "ghidra" "ida" "ollydbg" "x64dbg" "immunity"
    "wireshark" "tcpdump" "tshark" "ettercap" "bettercap"
    "mitmproxy" "burpsuite" "zap" "w3af" "nikto" "sqlmap"
    "metasploit" "empire" "cobaltstrike" "sliver" "merlin"
    "crackmapexec" "impacket" "bloodhound" "kerbrute" "responder"
    "evil-winrm" "chisel" "socat" "netcat" "ncat" "socat"
    "proxychains" "sshuttle" "iodine" "dnscat2" "tunna"
    "chisel" "socat" "netcat" "ncat" "socat" "proxychains"
    "sshuttle" "iodine" "dnscat2" "tunna" "chisel" "socat"
)

# Enhanced Color System
declare -A COLORS=(
    ["RED"]='\033[1;31m'
    ["GREEN"]='\033[1;32m'
    ["YELLOW"]='\033[1;33m'
    ["BLUE"]='\033[1;34m'
    ["PURPLE"]='\033[1;35m'
    ["CYAN"]='\033[1;36m'
    ["WHITE"]='\033[1;37m'
    ["ORANGE"]='\033[1;38;5;208m'
    ["PINK"]='\033[1;38;5;206m'
    ["LIME"]='\033[1;38;5;118m'
    ["NC"]='\033[0m'
)

# Enhanced Unicode Characters
declare -A UNICODE=(
    ["BORDER_TOP"]="╭─────────────────────────────────────────────────────────────────╮"
    ["BORDER_BOTTOM"]="╰─────────────────────────────────────────────────────────────────╯"
    ["BORDER_SIDE"]="│"
    ["BORDER_MIDDLE"]="├─────────────────────────────────────────────────────────────────┤"
    ["SPARKLE"]="✨"
    ["CHECK"]="✓"
    ["WARNING"]="⚠"
    ["ERROR"]="✗"
    ["INFO"]="ℹ"
    ["STAR"]="★"
    ["DIAMOND"]="♦"
    ["HEART"]="♥"
    ["ARROW"]="➜"
    ["LOADING"]=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    ["PROGRESS_BAR_FILL"]="█"
    ["PROGRESS_BAR_EMPTY"]="░"
    ["BULLET"]="•"
    ["CROSS"]="✖"
    ["LOCK"]="🔒"
    ["UNLOCK"]="🔓"
    ["KEY"]="🔑"
    ["SHIELD"]="🛡️"
    ["SWORD"]="⚔️"
    ["WRENCH"]="🔧"
    ["GEAR"]="⚙️"
    ["LIGHTNING"]="⚡"
    ["FIRE"]="🔥"
    ["TARGET"]="🎯"
    ["SKULL"]="💀"
    ["GHOST"]="👻"
    ["ROBOT"]="🤖"
    ["TERMINAL"]="💻"
    ["SATELLITE"]="📡"
    ["MAGNIFIER"]="🔍"
    ["TOOLS"]="🛠️"
    ["DOWNLOAD"]="📥"
    ["SUCCESS"]="✅"
    ["FAILED"]="❌"
    ["LOADING_WHEEL"]="🔄"
    ["PACKAGE"]="📦"
    ["CLOCK"]="⏰"
    ["CHART"]="📊"
    ["FOLDER"]="📁"
)

# Enhanced Logging System
log() {
    local level=$1
    local message=$2
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    local log_level_color
    local log_level_icon
    
    case $level in
        "INFO")
            log_level_color=${COLORS["BLUE"]}
            log_level_icon=${UNICODE["INFO"]}
            ;;
        "WARNING")
            log_level_color=${COLORS["YELLOW"]}
            log_level_icon=${UNICODE["WARNING"]}
            ;;
        "ERROR")
            log_level_color=${COLORS["RED"]}
            log_level_icon=${UNICODE["ERROR"]}
            ;;
        "SUCCESS")
            log_level_color=${COLORS["GREEN"]}
            log_level_icon=${UNICODE["CHECK"]}
            ;;
        *)
            log_level_color=${COLORS["WHITE"]}
            log_level_icon=${UNICODE["INFO"]}
            ;;
    esac
    
    echo -e "${log_level_color}[${log_level_icon}] ${message}${COLORS["NC"]}"
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
}

# Enhanced Error Handling
handle_error() {
    local error_code=$1
    local line_number=$2
    local error_message="Error en línea $line_number: ${BASH_COMMAND}"
    
    log "ERROR" "$error_message"
    
    case $error_code in
        1) log "ERROR" "Error de permisos" ;;
        2) log "ERROR" "Error de red" ;;
        3) log "ERROR" "Error de dependencias" ;;
        4) log "ERROR" "Error de instalación" ;;
        5) log "ERROR" "Error de configuración" ;;
        *) log "ERROR" "Error desconocido (código: $error_code)" ;;
    esac
    
    # Cleanup on error
    cleanup_on_error
}

# Enhanced System Validation
validate_system() {
    log "INFO" "Validando sistema..."
    
    # Check CPU
    local cpu_cores=$(nproc)
    if [ "$cpu_cores" -lt "$MIN_CPU_CORES" ]; then
        log "ERROR" "CPU insuficiente. Se requieren al menos $MIN_CPU_CORES núcleos"
        return 1
    fi
    
    # Check RAM
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    if [ "$total_ram" -lt "$MIN_RAM_MB" ]; then
        log "ERROR" "RAM insuficiente. Se requieren al menos $MIN_RAM_MB MB"
        return 1
    fi
    
    # Check disk space
    local free_space=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
    if [ "$free_space" -lt "$MIN_DISK_GB" ]; then
        log "ERROR" "Espacio en disco insuficiente. Se requieren al menos $MIN_DISK_GB GB"
        return 1
    fi
    
    # Check required commands
    for cmd in "${REQUIRED_COMMANDS[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            log "ERROR" "Comando requerido no encontrado: $cmd"
            return 1
        fi
    done
    
    log "SUCCESS" "Validación del sistema completada"
    return 0
}

# Enhanced Directory Management
create_directory_structure() {
    log "INFO" "Creando estructura de directorios..."
    
    local directories=(
        "$MODULES_DIR"
        "$PLUGINS_DIR"
        "$SCRIPTS_DIR"
        "$CACHE_DIR"
        "$TEMP_DIR"
        "$BACKUP_DIR"
        "$REPORTS_DIR"
    )
    
    for dir in "${directories[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            chmod 750 "$dir"
            log "INFO" "Directorio creado: $dir"
        fi
    done
    
    # Create module subdirectories
    for module in "${!MODULES[@]}"; do
        mkdir -p "$MODULES_DIR/$module"
    done
    
    log "SUCCESS" "Estructura de directorios creada exitosamente"
}

# Enhanced Configuration Management
load_configuration() {
    if [ -f "$CONFIG_FILE" ]; then
        log "INFO" "Cargando configuración desde $CONFIG_FILE"
        source "$CONFIG_FILE"
    else
        log "WARNING" "Archivo de configuración no encontrado, creando uno nuevo"
        create_default_config
    fi
}

create_default_config() {
    log "INFO" "Creando configuración predeterminada"
    cat > "$CONFIG_FILE" << EOF
# SOKIX Toolkit Configuration
version: $VERSION
update_check: true
auto_backup: true
max_log_size: 100M
debug_mode: false
proxy_enabled: false
proxy_address: ""
modules:
  enabled: true
  auto_update: true
  cache_enabled: true
security:
  encryption_enabled: true
  backup_encryption: true
  audit_logging: true
performance:
  max_threads: 4
  cache_size: 1G
  compression_level: 6
EOF
    chmod 640 "$CONFIG_FILE"
    chown root:root "$CONFIG_FILE"
}

# Enhanced Tool Management
declare -A TOOLS=(
    # Exploitation Tools
    ["metasploit"]="Framework de explotación y pruebas de penetración"
    ["exploitdb"]="Base de datos de exploits"
    ["sqlmap"]="Herramienta de inyección SQL"
    ["hydra"]="Herramienta de fuerza bruta"
    ["john"]="Herramienta de cracking de contraseñas"
    ["hashcat"]="Herramienta avanzada de cracking de hashes"
    ["crackmapexec"]="Herramienta de post-explotación"
    ["impacket"]="Colección de scripts de Python para trabajar con protocolos de red"
    ["responder"]="Herramienta de envenenamiento LLMNR/NBT-NS/MDNS"
    ["evil-winrm"]="Shell WinRM para pentesting"
    
    # Network Tools
    ["nmap"]="Escáner de red"
    ["masscan"]="Escáner de puertos masivo"
    ["zmap"]="Escáner de red de Internet"
    ["tcpdump"]="Analizador de paquetes"
    ["wireshark"]="Analizador de protocolos de red"
    ["ettercap"]="Suite para ataques MITM"
    ["bettercap"]="Framework de pentesting"
    ["mitmproxy"]="Proxy para análisis de tráfico"
    
    # Web Tools
    ["burpsuite"]="Plataforma de seguridad para aplicaciones web"
    ["zap"]="Proxy de seguridad de aplicaciones web"
    ["w3af"]="Framework de auditoría de aplicaciones web"
    ["nikto"]="Escáner de vulnerabilidades web"
    ["gobuster"]="Herramienta de fuzzing de directorios"
    ["dirb"]="Escáner de directorios web"
    ["wpscan"]="Escáner de seguridad para WordPress"
    ["joomscan"]="Escáner de seguridad para Joomla"
    ["droopescan"]="Escáner de seguridad para Drupal"
    
    # Wireless Tools
    ["aircrack-ng"]="Suite de herramientas de seguridad inalámbrica"
    ["reaver"]="Herramienta de ataque WPS"
    ["wifite"]="Herramienta automatizada de auditoría inalámbrica"
    
    # OSINT Tools
    ["theharvester"]="Herramienta de recolección de información"
    ["maltego"]="Herramienta de análisis de enlaces"
    ["spiderfoot"]="Herramienta de inteligencia de código abierto"
    ["recon-ng"]="Framework de reconocimiento"
    ["sherlock"]="Herramienta de búsqueda de nombres de usuario"
    
    # Forensic Tools
    ["autopsy"]="Plataforma forense digital"
    ["volatility"]="Framework de análisis de memoria"
    ["binwalk"]="Herramienta de análisis de firmware"
    ["foremost"]="Herramienta de recuperación de archivos"
    ["scalpel"]="Herramienta de recuperación de archivos"
    
    # Reverse Engineering
    ["radare2"]="Framework de ingeniería inversa"
    ["ghidra"]="Herramienta de ingeniería inversa"
    ["ida"]="Desensamblador y depurador"
    ["ollydbg"]="Depurador de 32 bits"
    ["x64dbg"]="Depurador de 64 bits"
    ["immunity"]="Depurador de Python"
    
    # Account Verification Tools
    ["amazon-verify"]="Verificación de cuentas de Amazon"
    ["apple-verify"]="Verificación de cuentas de Apple"
    ["gmail-verify"]="Verificación de cuentas de Gmail"
    ["linkedin-verify"]="Verificación de cuentas de LinkedIn"
    ["myspace-verify"]="Verificación de cuentas de Myspace"
    ["twitter-verify"]="Verificación de cuentas de Twitter"
    
    # Social Media Tools
    ["social-analyzer"]="Análisis de perfiles de redes sociales"
    ["sherlock"]="Búsqueda de nombres de usuario en redes sociales"
    ["social_mapper"]="Mapeo de perfiles en redes sociales"
    ["twint"]="Herramienta avanzada de Twitter"
    ["instaloader"]="Descarga de contenido de Instagram"
    
    # Email Tools
    ["emailharvester"]="Recolección de direcciones de correo"
    ["holehe"]="Verificación de cuentas de correo"
    ["h8mail"]="Búsqueda de contraseñas filtradas"
    ["infoga"]="Recolección de información de correo"
    ["theharvester"]="Recolección de información de correo"
    
    # DDoS Tools
    ["slowloris"]="Herramienta de ataque DoS"
    ["goldeneye"]="Herramienta de prueba de DoS"
    ["hulk"]="Herramienta de prueba de DoS"
    ["xerxes"]="Herramienta de prueba de DoS"
    ["torhammer"]="Herramienta de prueba de DoS"
    
    # Phishing Tools
    ["gophish"]="Framework de phishing"
    ["socialfish"]="Herramienta de phishing"
    ["zphisher"]="Herramienta de phishing"
    ["blackeye"]="Herramienta de phishing"
    ["shellphish"]="Herramienta de phishing"
    
    # Virus Tools
    ["maltego"]="Análisis de malware"
    ["cuckoo"]="Sandbox de análisis de malware"
    ["yara"]="Herramienta de identificación de malware"
    ["clamav"]="Antivirus de código abierto"
    ["virustotal"]="Análisis de archivos sospechosos"
    
    # IP Tools
    ["ipinfo"]="Información de IP"
    ["ip2location"]="Geolocalización de IP"
    ["ipapi"]="API de información de IP"
    ["ipdata"]="Datos de IP"
    ["ipstack"]="Stack de información de IP"
    
    # New Categories
    ["mobile"]="Herramientas de seguridad móvil"
    ["cloud"]="Herramientas de seguridad en la nube"
    ["crypto"]="Herramientas criptográficas"
    ["defense"]="Herramientas de defensa de red"
    ["incident"]="Herramientas de respuesta a incidentes"
    ["threat"]="Herramientas de inteligencia de amenazas"
    ["compliance"]="Herramientas de cumplimiento"
    ["redteam"]="Herramientas de equipo rojo"
    ["blueteam"]="Herramientas de equipo azul"
    ["purpleteam"]="Herramientas de equipo púrpura"
)

# Enhanced Module System
declare -A MODULES=(
    ["exploitation"]="Exploitation Tools"
    ["network"]="Network Tools"
    ["web"]="Web Tools"
    ["mobile"]="Mobile Security"
    ["cloud"]="Cloud Security"
    ["crypto"]="Cryptographic Tools"
    ["wireless"]="Wireless Security"
    ["osint"]="OSINT Tools"
    ["forensics"]="Forensic Tools"
    ["malware"]="Malware Analysis"
    ["reverse"]="Reverse Engineering"
    ["iot"]="IoT Security"
    ["social"]="Social Engineering"
    ["password"]="Password Tools"
    ["defense"]="Network Defense"
    ["incident"]="Incident Response"
    ["threat"]="Threat Intelligence"
    ["compliance"]="Compliance Tools"
    ["redteam"]="Red Team Tools"
    ["blueteam"]="Blue Team Tools"
    ["purpleteam"]="Purple Team Tools"
    ["account_verification"]="Account Verification"
    ["social_media"]="Social Media Tools"
    ["email"]="Email Tools"
    ["ddos"]="DDoS Tools"
    ["phishing"]="Phishing Tools"
    ["virus"]="Virus Tools"
    ["ip"]="IP Tools"
)

# Enhanced Tool Management
install_tool() {
    local tool=$1
    local version=$2
    local repo_url=$3
    
    log "INFO" "Instalando $tool v$version..."
    
    # Create tool directory
    local tool_dir="$MODULES_DIR/${tool%%-*}/$tool"
    mkdir -p "$tool_dir"
    
    # Clone repository
    if ! git clone --depth 1 --branch "$version" "$repo_url" "$tool_dir"; then
        log "ERROR" "Error al clonar $tool"
        return 1
    fi
    
    # Install dependencies
    if [ -f "$tool_dir/requirements.txt" ]; then
        log "INFO" "Instalando dependencias para $tool..."
        pip3 install -r "$tool_dir/requirements.txt"
    fi
    
    # Set permissions
    find "$tool_dir" -type f -exec chmod 750 {} \;
    find "$tool_dir" -type d -exec chmod 755 {} \;
    
    log "SUCCESS" "$tool instalado correctamente"
    return 0
}

# Enhanced Backup System
create_backup() {
    local backup_name="sokix_backup_$(date +%Y%m%d_%H%M%S)"
    local backup_dir="$BACKUP_DIR/$backup_name"
    
    log "INFO" "Creando copia de seguridad..."
    
    mkdir -p "$backup_dir"
    
    # Backup configuration
    cp -r "$CONFIG_FILE" "$backup_dir/config.yaml"
    
    # Backup modules
    cp -r "$MODULES_DIR" "$backup_dir/modules"
    
    # Backup plugins
    cp -r "$PLUGINS_DIR" "$backup_dir/plugins"
    
    # Backup scripts
    cp -r "$SCRIPTS_DIR" "$backup_dir/scripts"
    
    # Create backup manifest
    cat > "$backup_dir/manifest.json" << EOF
{
    "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "version": "$VERSION",
    "toolkit_name": "$TOOLKIT_NAME",
    "size": "$(du -sh "$backup_dir" | cut -f1)"
}
EOF
    
    # Compress backup
    tar -czf "$BACKUP_DIR/$backup_name.tar.gz" -C "$BACKUP_DIR" "$backup_name"
    rm -rf "$backup_dir"
    
    log "SUCCESS" "Backup creado: $backup_name.tar.gz"
}

# Enhanced Security Functions
encrypt_data() {
    local data=$1
    local key=$2
    
    echo "$data" | openssl enc -aes-256-cbc -salt -pass pass:"$key" -base64
}

decrypt_data() {
    local encrypted_data=$1
    local key=$2
    
    echo "$encrypted_data" | openssl enc -d -aes-256-cbc -salt -pass pass:"$key" -base64
}

# Enhanced Performance Optimization
optimize_performance() {
    log "INFO" "Optimizando rendimiento..."
    
    # Adjust system limits
    ulimit -n 65535
    ulimit -u 65535
    
    # Enable performance governor
    if command -v cpufreq-set &> /dev/null; then
        cpufreq-set -g performance
    fi
    
    # Optimize network settings
    sysctl -w net.core.rmem_max=16777216
    sysctl -w net.core.wmem_max=16777216
    sysctl -w net.ipv4.tcp_rmem="4096 87380 16777216"
    sysctl -w net.ipv4.tcp_wmem="4096 87380 16777216"
    
    log "SUCCESS" "Optimización de rendimiento completada"
}

# Enhanced Cleanup
cleanup() {
    log "INFO" "Limpiando recursos..."
    
    # Remove temporary files
    rm -rf "$TEMP_DIR"/*
    
    # Clear cache if too large
    local cache_size=$(du -sm "$CACHE_DIR" | cut -f1)
    if [ "$cache_size" -gt 1024 ]; then
        log "WARNING" "Cache demasiado grande ($cache_size MB), limpiando..."
        rm -rf "$CACHE_DIR"/*
    fi
    
    # Rotate logs
    if [ -f "$LOG_FILE" ]; then
        local log_size=$(du -m "$LOG_FILE" | cut -f1)
        if [ "$log_size" -gt 100 ]; then
            log "INFO" "Rotando logs..."
            mv "$LOG_FILE" "$LOG_FILE.old"
            touch "$LOG_FILE"
        fi
    fi
    
    log "SUCCESS" "Limpieza completada"
}

# Enhanced Auto-Diagnostic System
perform_auto_diagnostic() {
    log "INFO" "Iniciando diagnóstico automático del sistema..."
    
    # Create diagnostic log
    echo "=== SOKIX Toolkit Auto-Diagnostic Report ===" > "$DIAGNOSTIC_FILE"
    echo "Timestamp: $(date)" >> "$DIAGNOSTIC_FILE"
    echo "Version: $VERSION" >> "$DIAGNOSTIC_FILE"
    
    # System Information
    echo -e "\n=== System Information ===" >> "$DIAGNOSTIC_FILE"
    echo "OS: $(uname -a)" >> "$DIAGNOSTIC_FILE"
    echo "Kernel: $(uname -r)" >> "$DIAGNOSTIC_FILE"
    echo "Architecture: $(uname -m)" >> "$DIAGNOSTIC_FILE"
    
    # CPU Information
    echo -e "\n=== CPU Information ===" >> "$DIAGNOSTIC_FILE"
    echo "CPU Model: $(cat /proc/cpuinfo | grep 'model name' | head -1 | cut -d: -f2)" >> "$DIAGNOSTIC_FILE"
    echo "CPU Cores: $(nproc)" >> "$DIAGNOSTIC_FILE"
    echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')" >> "$DIAGNOSTIC_FILE"
    
    # Memory Information
    echo -e "\n=== Memory Information ===" >> "$DIAGNOSTIC_FILE"
    echo "Total RAM: $(free -h | grep Mem | awk '{print $2}')" >> "$DIAGNOSTIC_FILE"
    echo "Used RAM: $(free -h | grep Mem | awk '{print $3}')" >> "$DIAGNOSTIC_FILE"
    echo "Free RAM: $(free -h | grep Mem | awk '{print $4}')" >> "$DIAGNOSTIC_FILE"
    
    # Disk Information
    echo -e "\n=== Disk Information ===" >> "$DIAGNOSTIC_FILE"
    echo "Total Disk: $(df -h / | awk 'NR==2 {print $2}')" >> "$DIAGNOSTIC_FILE"
    echo "Used Disk: $(df -h / | awk 'NR==2 {print $3}')" >> "$DIAGNOSTIC_FILE"
    echo "Free Disk: $(df -h / | awk 'NR==2 {print $4}')" >> "$DIAGNOSTIC_FILE"
    
    # Network Information
    echo -e "\n=== Network Information ===" >> "$DIAGNOSTIC_FILE"
    echo "IP Address: $(hostname -I | awk '{print $1}')" >> "$DIAGNOSTIC_FILE"
    echo "Network Interfaces: $(ip link show | grep '^[0-9]' | awk -F: '{print $2}')" >> "$DIAGNOSTIC_FILE"
    
    # Performance Metrics
    echo -e "\n=== Performance Metrics ===" >> "$DIAGNOSTIC_FILE"
    echo "Load Average: $(uptime | awk '{print $10 $11 $12}')" >> "$DIAGNOSTIC_FILE"
    echo "IO Wait: $(iostat -c | awk 'NR==4 {print $4}')%" >> "$DIAGNOSTIC_FILE"
    echo "Context Switches: $(vmstat 1 2 | tail -1 | awk '{print $12}')" >> "$DIAGNOSTIC_FILE"
    
    # Security Checks
    echo -e "\n=== Security Checks ===" >> "$DIAGNOSTIC_FILE"
    echo "SELinux Status: $(getenforce)" >> "$DIAGNOSTIC_FILE"
    echo "Firewall Status: $(systemctl is-active firewalld)" >> "$DIAGNOSTIC_FILE"
    echo "Last Security Updates: $(rpm -qa --last | grep security | head -1)" >> "$DIAGNOSTIC_FILE"
    
    # Tool Dependencies
    echo -e "\n=== Tool Dependencies ===" >> "$DIAGNOSTIC_FILE"
    for cmd in "${REQUIRED_COMMANDS[@]}"; do
        if command -v "$cmd" &> /dev/null; then
            echo "$cmd: Installed ($(which $cmd))" >> "$DIAGNOSTIC_FILE"
        else
            echo "$cmd: Not Installed" >> "$DIAGNOSTIC_FILE"
        fi
    done
    
    # Performance Optimization Recommendations
    echo -e "\n=== Performance Optimization Recommendations ===" >> "$DIAGNOSTIC_FILE"
    local cpu_cores=$(nproc)
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    local free_space=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
    
    if [ "$cpu_cores" -lt "$MIN_CPU_CORES" ]; then
        echo "WARNING: CPU cores below minimum requirement. Consider upgrading hardware." >> "$DIAGNOSTIC_FILE"
    fi
    
    if [ "$total_ram" -lt "$MIN_RAM_MB" ]; then
        echo "WARNING: RAM below minimum requirement. Consider upgrading hardware." >> "$DIAGNOSTIC_FILE"
    fi
    
    if [ "$free_space" -lt "$MIN_DISK_GB" ]; then
        echo "WARNING: Disk space below minimum requirement. Consider freeing up space." >> "$DIAGNOSTIC_FILE"
    fi
    
    # Automatic Performance Optimization
    optimize_performance_auto
    
    log "SUCCESS" "Diagnóstico automático completado. Ver $DIAGNOSTIC_FILE para detalles."
}

# Enhanced Automatic Performance Optimization
optimize_performance_auto() {
    log "INFO" "Iniciando optimización automática de rendimiento..."
    
    # Create performance log
    echo "=== SOKIX Toolkit Performance Optimization ===" > "$PERFORMANCE_FILE"
    echo "Timestamp: $(date)" >> "$PERFORMANCE_FILE"
    
    # CPU Optimization
    echo -e "\n=== CPU Optimization ===" >> "$PERFORMANCE_FILE"
    if command -v cpufreq-set &> /dev/null; then
        cpufreq-set -g performance
        echo "CPU Governor set to performance mode" >> "$PERFORMANCE_FILE"
    fi
    
    # Memory Optimization
    echo -e "\n=== Memory Optimization ===" >> "$PERFORMANCE_FILE"
    sysctl -w vm.swappiness=10
    sysctl -w vm.dirty_ratio=60
    sysctl -w vm.dirty_background_ratio=2
    echo "Memory parameters optimized" >> "$PERFORMANCE_FILE"
    
    # Network Optimization
    echo -e "\n=== Network Optimization ===" >> "$PERFORMANCE_FILE"
    sysctl -w net.core.rmem_max=16777216
    sysctl -w net.core.wmem_max=16777216
    sysctl -w net.ipv4.tcp_rmem="4096 87380 16777216"
    sysctl -w net.ipv4.tcp_wmem="4096 87380 16777216"
    sysctl -w net.ipv4.tcp_window_scaling=1
    sysctl -w net.ipv4.tcp_timestamps=1
    sysctl -w net.ipv4.tcp_sack=1
    sysctl -w net.core.somaxconn=65535
    sysctl -w net.ipv4.tcp_max_syn_backlog=65535
    echo "Network parameters optimized" >> "$PERFORMANCE_FILE"
    
    # Disk I/O Optimization
    echo -e "\n=== Disk I/O Optimization ===" >> "$PERFORMANCE_FILE"
    sysctl -w vm.dirty_writeback_centisecs=100
    sysctl -w vm.dirty_expire_centisecs=500
    echo "Disk I/O parameters optimized" >> "$PERFORMANCE_FILE"
    
    # System Limits
    echo -e "\n=== System Limits ===" >> "$PERFORMANCE_FILE"
    ulimit -n 65535
    ulimit -u 65535
    echo "System limits increased" >> "$PERFORMANCE_FILE"
    
    # Cache Optimization
    echo -e "\n=== Cache Optimization ===" >> "$PERFORMANCE_FILE"
    if [ -d "$CACHE_DIR" ]; then
        find "$CACHE_DIR" -type f -mtime +7 -delete
        echo "Cache cleaned" >> "$PERFORMANCE_FILE"
    fi
    
    log "SUCCESS" "Optimización automática de rendimiento completada. Ver $PERFORMANCE_FILE para detalles."
}

# Kali Linux Specific Configuration
check_kali_linux() {
    log "INFO" "Verificando compatibilidad con Kali Linux..."
    
    # Check if running on Kali Linux
    if [ -f "/etc/os-release" ]; then
        if grep -q "Kali GNU/Linux" /etc/os-release; then
            log "SUCCESS" "Sistema Kali Linux detectado"
            
            # Check Kali version
            local kali_version=$(grep "VERSION=" /etc/os-release | cut -d'"' -f2)
            log "INFO" "Versión de Kali: $kali_version"
            
            # Check Kali repositories
            if [ -f "/etc/apt/sources.list" ]; then
                if grep -q "kali.org" /etc/apt/sources.list; then
                    log "SUCCESS" "Repositorios oficiales de Kali configurados"
                else
                    log "WARNING" "Repositorios oficiales de Kali no encontrados"
                    configure_kali_repositories
                fi
            fi
            
            # Check Kali metapackages
            check_kali_metapackages
            
            # Configure Kali specific settings
            configure_kali_settings
            
            return 0
        else
            log "ERROR" "Este sistema no es Kali Linux"
            return 1
        fi
    else
        log "ERROR" "No se puede determinar el sistema operativo"
        return 1
    fi
}

configure_kali_repositories() {
    log "INFO" "Configurando repositorios oficiales de Kali..."
    
    # Backup original sources.list
    cp /etc/apt/sources.list /etc/apt/sources.list.bak
    
    # Add official Kali repositories
    cat > /etc/apt/sources.list << EOF
deb http://http.kali.org/kali kali-rolling main contrib non-free
deb-src http://http.kali.org/kali kali-rolling main contrib non-free
EOF
    
    # Update package lists
    apt-get update
    
    log "SUCCESS" "Repositorios de Kali configurados correctamente"
}

check_kali_metapackages() {
    log "INFO" "Verificando metapaquetes de Kali..."
    
    local required_metapackages=(
        "kali-linux-core"
        "kali-linux-default"
        "kali-tools-top10"
        "kali-tools-web"
        "kali-tools-database"
        "kali-tools-passwords"
        "kali-tools-wireless"
        "kali-tools-reverse-engineering"
        "kali-tools-exploitation"
        "kali-tools-social-engineering"
        "kali-tools-sniffing-spoofing"
        "kali-tools-vulnerability"
        "kali-tools-forensics"
        "kali-tools-reporting"
    )
    
    for pkg in "${required_metapackages[@]}"; do
        if ! dpkg -l | grep -q "^ii  $pkg "; then
            log "WARNING" "Metapaquete $pkg no instalado"
            install_kali_metapackage "$pkg"
        fi
    done
}

install_kali_metapackage() {
    local pkg=$1
    log "INFO" "Instalando metapaquete $pkg..."
    
    apt-get install -y "$pkg"
    
    if [ $? -eq 0 ]; then
        log "SUCCESS" "Metapaquete $pkg instalado correctamente"
    else
        log "ERROR" "Error al instalar metapaquete $pkg"
    fi
}

configure_kali_settings() {
    log "INFO" "Configurando ajustes específicos de Kali..."
    
    # Configure PostgreSQL for Metasploit
    if command -v postgresql &> /dev/null; then
        systemctl enable postgresql
        systemctl start postgresql
        msfdb init
    fi
    
    # Configure network settings
    sysctl -w net.ipv4.ip_forward=1
    sysctl -w net.ipv6.conf.all.forwarding=1
    
    # Configure firewall
    if command -v ufw &> /dev/null; then
        ufw default deny incoming
        ufw default allow outgoing
        ufw enable
    fi
    
    # Configure ZSH and Oh My ZSH
    if command -v zsh &> /dev/null; then
        chsh -s /bin/zsh
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi
    fi
    
    # Configure system performance
    sysctl -w vm.swappiness=10
    sysctl -w vm.dirty_ratio=60
    sysctl -w vm.dirty_background_ratio=2
    
    # Configure system limits
    echo "* soft nofile 65535" >> /etc/security/limits.conf
    echo "* hard nofile 65535" >> /etc/security/limits.conf
    
    log "SUCCESS" "Ajustes de Kali configurados correctamente"
}

# Enhanced Main Program
main() {
    # Initialize
    log "INFO" "Iniciando $TOOLKIT_NAME v$VERSION"
    
    # Check Kali Linux compatibility
    if ! check_kali_linux; then
        log "ERROR" "Este toolkit requiere Kali Linux"
        exit 1
    fi
    
    # Perform auto-diagnostic
    perform_auto_diagnostic
    
    # Validate system
    if ! validate_system; then
        log "ERROR" "Validación del sistema fallida"
        exit 1
    fi
    
    # Create directory structure
    create_directory_structure
    
    # Load configuration
    load_configuration
    
    # Optimize performance
    optimize_performance
    
    # Main loop
    while true; do
        show_main_menu
        read -r option
        
        case $option in
            1) handle_settings_menu ;;
            2) handle_modules_menu ;;
            3) handle_tools_menu ;;
            4) handle_backup_menu ;;
            5) handle_security_menu ;;
            6) cleanup_and_exit 0 ;;
            *) log "ERROR" "Opción inválida" ;;
        esac
    done
}

# Start the program
main
