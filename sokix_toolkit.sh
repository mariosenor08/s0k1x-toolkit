#!/bin/bash

# SOKIX Toolkit - Professional Ethical Hacking Environment
# Version: 8.0.0
# License: MIT
# Author: SOKIX Security Team

# Enhanced strict mode with advanced error handling
set -euo pipefail
IFS=$'\n\t'

# Advanced Global Configuration
readonly VERSION="8.0.0"
readonly TOOLKIT_NAME="SOKIX Professional Hacking Toolkit"
readonly CONFIG_FILE="/etc/sokix/config.yaml"
readonly LOG_FILE="/var/log/sokix/hacking.log"
readonly TOOLS_DIR="/usr/share/sokix/tools"
readonly MODULES_DIR="/usr/share/sokix/modules"
readonly SCRIPTS_DIR="/usr/share/sokix/scripts"
readonly CACHE_DIR="/var/cache/sokix"
readonly TEMP_DIR="/tmp/sokix"
readonly BACKUP_DIR="/var/backups/sokix"
readonly REPORTS_DIR="/var/reports/sokix"
readonly EXPLOITS_DIR="/usr/share/sokix/exploits"
readonly PAYLOADS_DIR="/usr/share/sokix/payloads"
readonly WORDLISTS_DIR="/usr/share/sokix/wordlists"
readonly DATABASES_DIR="/usr/share/sokix/databases"
readonly PROXIES_DIR="/usr/share/sokix/proxies"
readonly TOR_DIR="/usr/share/sokix/tor"
readonly VPN_DIR="/usr/share/sokix/vpn"
readonly SHELLS_DIR="/usr/share/sokix/shells"
readonly BACKDOORS_DIR="/usr/share/sokix/backdoors"
readonly MALWARE_DIR="/usr/share/sokix/malware"
readonly REVERSE_DIR="/usr/share/sokix/reverse"
readonly BRUTE_DIR="/usr/share/sokix/brute"
readonly FUZZING_DIR="/usr/share/sokix/fuzzing"
readonly SCANNING_DIR="/usr/share/sokix/scanning"
readonly ENUMERATION_DIR="/usr/share/sokix/enumeration"
readonly PRIVILEGE_DIR="/usr/share/sokix/privilege"
readonly PERSISTENCE_DIR="/usr/share/sokix/persistence"
readonly LATERAL_DIR="/usr/share/sokix/lateral"
readonly EXFILTRATION_DIR="/usr/share/sokix/exfiltration"
readonly COVERING_DIR="/usr/share/sokix/covering"

# Advanced Color System with RGB support
declare -A COLORS
COLORS=(
    ["RED"]="\033[1;31m"
    ["GREEN"]="\033[1;32m"
    ["YELLOW"]="\033[1;33m"
    ["BLUE"]="\033[1;34m"
    ["PURPLE"]="\033[1;35m"
    ["CYAN"]="\033[1;36m"
    ["WHITE"]="\033[1;37m"
    ["ORANGE"]="\033[1;38;5;208m"
    ["PINK"]="\033[1;38;5;206m"
    ["LIME"]="\033[1;38;5;118m"
    ["MATRIX"]="\033[1;38;5;40m"
    ["HACKER"]="\033[1;38;5;196m"
    ["CYBERPUNK"]="\033[1;38;5;99m"
    ["STEALTH"]="\033[1;38;5;240m"
    ["NEON"]="\033[1;38;5;45m"
    ["NC"]="\033[0m"
)

# Advanced Unicode Characters with more options
declare -A UNICODE
UNICODE=(
    ["BORDER_TOP"]="+-----------------------------------------+"
    ["BORDER_BOTTOM"]="+-----------------------------------------+"
    ["BORDER_SIDE"]="|"
    ["BORDER_MIDDLE"]="|------------------------------------------|"
    ["SPARKLE"]="*"
    ["CHECK"]="√"
    ["WARNING"]="!"
    ["ERROR"]="x"
    ["INFO"]="i"
    ["STAR"]="*"
    ["DIAMOND"]="<>"
    ["HEART"]="<3"
    ["ARROW"]=">"
    ["LOADING"]="/-\|"
    ["PROGRESS_BAR_FILL"]="#"
    ["PROGRESS_BAR_EMPTY"]="."
    ["BULLET"]="*"
    ["CROSS"]="X"
    ["LOCK"]="[X]"
    ["UNLOCK"]="[ ]"
    ["KEY"]="key"
    ["SHIELD"]="[S]"
    ["SWORD"]="[W]"
    ["WRENCH"]="[T]"
    ["GEAR"]="[G]"
    ["LIGHTNING"]="[L]"
    ["FIRE"]="[F]"
    ["TARGET"]="[O]"
    ["SKULL"]="[D]"
    ["GHOST"]="[H]"
    ["ROBOT"]="[R]"
    ["TERMINAL"]="[>]"
    ["SATELLITE"]="[^]"
    ["MAGNIFIER"]="[M]"
    ["TOOLS"]="[T]"
    ["DOWNLOAD"]="[D]"
    ["SUCCESS"]="[OK]"
    ["FAILED"]="[!!]"
    ["LOADING_WHEEL"]="[*]"
    ["PACKAGE"]="[P]"
    ["CLOCK"]="[C]"
    ["CHART"]="[#]"
    ["FOLDER"]="[/]"
    ["GAME"]="[G]"
    ["MOBILE"]="[M]"
    ["NETWORK"]="[N]"
    ["SECURITY"]="[S]"
    ["HACKING"]="[H]"
    ["SCANNING"]="[S]"
    ["EXPLOITING"]="[E]"
    ["CRACKING"]="[C]"
    ["SOCIAL"]="[S]"
    ["FORENSICS"]="[F]"
    ["REPORT"]="[R]"
    ["SETTINGS"]="[S]"
    ["UPDATE"]="[U]"
    ["EXIT"]="[X]"
)

# Sistema de diagnóstico mejorado
declare -A DIAGNOSTIC_CHECKS=(
    [system]="Verificando sistema operativo y recursos"
    [network]="Comprobando conectividad y servicios de red"
    [security]="Analizando configuraciones de seguridad"
    [performance]="Evaluando rendimiento del sistema"
    [dependencies]="Revisando dependencias y paquetes"
    [tools]="Verificando estado de las herramientas"
    [permissions]="Comprobando permisos y accesos"
    [storage]="Analizando espacio en disco"
    [memory]="Verificando uso de memoria"
    [cpu]="Comprobando carga del procesador"
)

# Advanced ASCII Art Banner
show_banner() {
    clear
    echo -e "${COLORS['PURPLE']}"
    echo "  ███████╗ ██████╗ ██╗  ██╗██╗██╗  ██╗"
    echo "  ██╔════╝██╔═══██╗██║ ██╔╝██║╚██╗██╔╝"
    echo "  ███████╗██║   ██║█████╔╝ ██║ ╚███╔╝ "
    echo "  ╚════██║██║   ██║██╔═██╗ ██║ ██╔██╗ "
    echo "  ███████║╚██████╔╝██║  ██╗██║██╔╝ ██╗"
    echo "  ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝"
    echo -e "${COLORS['NC']}"
    echo -e "${COLORS['CYAN']}Professional Ethical Hacking Environment v$VERSION${COLORS['NC']}"
    echo -e "${COLORS['YELLOW']}Copyright (c) 2024 SOKIX Security Team${COLORS['NC']}"
    echo
}

# Enhanced Main Menu with Categories
show_main_menu() {
    clear
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_TOP']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['TERMINAL']} SOKIX Toolkit v$VERSION ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    # Categoría: OSINT
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['MAGNIFIER']} Herramientas OSINT ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}1.${COLORS['NC']} AllHackingTools ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}2.${COLORS['NC']} NetSoc_OSINT ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}3.${COLORS['NC']} OSINT-Framework ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}4.${COLORS['NC']} ReconDog ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}5.${COLORS['NC']} OSINT-Tool ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}6.${COLORS['NC']} OSINT-Toolkit ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Explotación Web
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['MAGNIFIER']} Explotación Web ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}7.${COLORS['NC']} XSS-Tools ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}8.${COLORS['NC']} D-TECT ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}9.${COLORS['NC']} XSStrike ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}10.${COLORS['NC']} SQLMap ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}11.${COLORS['NC']} WPScan ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}12.${COLORS['NC']} Burp Suite ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}13.${COLORS['NC']} OWASP ZAP ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}14.${COLORS['NC']} BeEF ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Explotación y Post-Explotación
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['SWORD']} Explotación y Post-Explotación ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}15.${COLORS['NC']} Metasploit Framework ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}16.${COLORS['NC']} Empire ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}17.${COLORS['NC']} Cobalt Strike ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}18.${COLORS['NC']} Mimikatz ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}19.${COLORS['NC']} CrackMapExec ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}20.${COLORS['NC']} Impacket ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Escaneo y Análisis de Red
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['SATELLITE']} Escaneo y Análisis de Red ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}21.${COLORS['NC']} Nmap ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}22.${COLORS['NC']} Wireshark ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}23.${COLORS['NC']} Bettercap ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}24.${COLORS['NC']} Nessus ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Análisis Web
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['MAGNIFIER']} Análisis Web ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}25.${COLORS['NC']} Burp Suite ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}26.${COLORS['NC']} ZAP (Zed Attack Proxy) ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}27.${COLORS['NC']} sqlmap ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}28.${COLORS['NC']} XSStrike ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}29.${COLORS['NC']} Vega ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}30.${COLORS['NC']} Nikto ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}31.${COLORS['NC']} Skipfish ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}32.${COLORS['NC']} Wfuzz ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: OSINT y Reconocimiento
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['MAGNIFIER']} OSINT y Reconocimiento ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}33.${COLORS['NC']} Maltego ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}34.${COLORS['NC']} Recon-ng ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}35.${COLORS['NC']} SpiderFoot ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}36.${COLORS['NC']} Amass ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}37.${COLORS['NC']} Sublist3r ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}38.${COLORS['NC']} Fierce ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}39.${COLORS['NC']} Subfinder ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}40.${COLORS['NC']} Dirsearch ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}41.${COLORS['NC']} Nuclei ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}42.${COLORS['NC']} Gobuster ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Ingeniería Social
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['GHOST']} Ingeniería Social ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}43.${COLORS['NC']} Social-Engineer Toolkit (SET) ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}44.${COLORS['NC']} GoPhish ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}45.${COLORS['NC']} Zphisher ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Análisis de Redes Inalámbricas
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['SATELLITE']} Análisis de Redes Inalámbricas ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}46.${COLORS['NC']} Aircrack-ng ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Herramientas de Cracking
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['KEY']} Herramientas de Cracking ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}47.${COLORS['NC']} Hashcat ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}48.${COLORS['NC']} John the Ripper ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}49.${COLORS['NC']} Hydra ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}50.${COLORS['NC']} Cewl ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Utilidades
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['TOOLS']} Utilidades ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}51.${COLORS['NC']} ProxyChains ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}52.${COLORS['NC']} GoReverseShell ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}53.${COLORS['NC']} T50 ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}54.${COLORS['NC']} Nginx Helper ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}55.${COLORS['NC']} Crackstation ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Sistema
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['GEAR']} Sistema ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}56.${COLORS['NC']} Configuración ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}57.${COLORS['NC']} Actualizaciones ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}58.${COLORS['NC']} Salir ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Hacking de Juegos
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['GAME']} Hacking de Juegos ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}59.${COLORS['NC']} Game Hacking Framework ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}60.${COLORS['NC']} Cheat Engine ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}61.${COLORS['NC']} Squalr ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}62.${COLORS['NC']} MungPlex ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}63.${COLORS['NC']} GTA SA Cheats ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}64.${COLORS['NC']} Payback2 Cheats ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}65.${COLORS['NC']} SimCity Cheat ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}66.${COLORS['NC']} Warzone2100 ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}67.${COLORS['NC']} StellarRealms ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}68.${COLORS['NC']} Online Games Hacking ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}69.${COLORS['NC']} Memory Signature Scanner ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}70.${COLORS['NC']} D3D11 Hook ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    # Categoría: Hacking de Aplicaciones Móviles
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['ORANGE']}${UNICODE['MOBILE']} Hacking de Aplicaciones Móviles ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}71.${COLORS['NC']} WhatsAppHacking ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}72.${COLORS['NC']} Android Studio ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}73.${COLORS['NC']} APKTool ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}74.${COLORS['NC']} Dex2Jar ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"
    echo -e "${COLORS['GREEN']}${UNICODE['SUCCESS']} Seleccione una herramienta o módulo para comenzar${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"
}

# Advanced Error Handling Function
handle_error() {
    local exit_code=$1
    local line_number=$2
    local error_message="Error en la línea $line_number con código de salida $exit_code"
    
    echo -e "${COLORS[RED]}${UNICODE[ERROR]} $error_message${COLORS[NC]}"
    echo -e "${COLORS[YELLOW]}${UNICODE[WARNING]} Intentando recuperar el sistema...${COLORS[NC]}"
    
    recover_system
    log_error "$error_message"
    show_error_options
}

# System Recovery Function
recover_system() {
    if [[ -d "$TOOLS_DIR" ]]; then
        chmod -R 755 "$TOOLS_DIR"
        chown -R "$(whoami)" "$TOOLS_DIR"
    fi
    
    check_dependencies
    verify_configurations
    clean_temp_files
}

# Configuration Verification Function
verify_configurations() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        create_default_config
    fi
    
    for dir in "$TOOLS_DIR" "$MODULES_DIR" "$SCRIPTS_DIR" "$CACHE_DIR" "$TEMP_DIR" "$BACKUP_DIR" "$REPORTS_DIR"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
        fi
    done
}

# Error Logging Function
log_error() {
    local message=$1
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] ERROR: $message" >> "$LOG_FILE"
}

# Show Error Options Function
show_error_options() {
    echo -e "${COLORS[YELLOW]}Opciones disponibles:${COLORS[NC]}"
    echo -e "1. ${COLORS[GREEN]}Reintentar operación${COLORS[NC]}"
    echo -e "2. ${COLORS[GREEN]}Verificar dependencias${COLORS[NC]}"
    echo -e "3. ${COLORS[GREEN]}Reparar configuración${COLORS[NC]}"
    echo -e "4. ${COLORS[GREEN]}Salir${COLORS[NC]}"
    
    read -p "Seleccione una opción: " option
    case $option in
        1) return 0 ;;
        2) check_dependencies ;;
        3) verify_configurations ;;
        4) exit 1 ;;
        *) echo -e "${COLORS[RED]}Opción inválida${COLORS[NC]}" ;;
    esac
}

# Clean Temporary Files Function
clean_temp_files() {
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "${TEMP_DIR:?}"/*
    fi
}

# Create Default Configuration Function
create_default_config() {
    cat > "$CONFIG_FILE" << EOF
# SOKIX Toolkit Configuration
version: $VERSION
theme: default
debug: false
log_level: info
auto_update: true
proxy_enabled: false
proxy_address: ""
proxy_port: ""
EOF
}

# Set up error trap
trap 'handle_error $? $LINENO' ERR

# Configuración avanzada del entorno
declare -a MODULES=(
    "core"
    "network"
    "web"
    "mobile"
    "osint"
    "exploitation"
    "post-exploitation"
    "forensics"
    "cracking"
    "social-engineering"
    "game-hacking"
    "custom"
)

# Sistema de módulos
declare -A MODULE_CONFIGS
MODULE_CONFIGS=(
    [core]="core_config.yaml"
    [network]="network_config.yaml"
    [web]="web_config.yaml"
    [mobile]="mobile_config.yaml"
    [osint]="osint_config.yaml"
    [exploitation]="exploitation_config.yaml"
    [post-exploitation]="post_exploitation_config.yaml"
    [forensics]="forensics_config.yaml"
    [cracking]="cracking_config.yaml"
    [social-engineering]="social_engineering_config.yaml"
    [game-hacking]="game_hacking_config.yaml"
    [custom]="custom_config.yaml"
)

# Sistema de temas
declare -A THEMES
THEMES=(
    [default]="\033[1;37m"
    [matrix]="\033[1;32m"
    [hacker]="\033[1;31m"
    [cyberpunk]="\033[1;35m"
    [stealth]="\033[1;30m"
    [neon]="\033[1;36m"
)

# Sistema de animaciones
declare -A ANIMATIONS
ANIMATIONS=(
    [loading]="⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏"
    [scanning]="▰ ▱"
    [hacking]="▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▇ ▆ ▅ ▄ ▃ ▂ ▁"
    [processing]="◐ ◓ ◑ ◒"
    [downloading]="⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷"
)

# Repositorios de GitHub para cada herramienta
declare -A GITHUB_REPOS=(
    # OSINT (20 herramientas)
    ["AllHackingTools"]="https://github.com/mishakorzik/AllHackingTools"
    ["NetSoc_OSINT"]="https://github.com/XDeadHackerX/NetSoc_OSINT"
    ["Recursos-Hacking-Etico"]="https://github.com/zamarrowski/recursos-hacking-etico"
    ["OSINT-Framework"]="https://github.com/lockfale/osint-framework"
    ["ReconDog"]="https://github.com/UltimateHackers/ReconDog"
    ["OSINT-Tool"]="https://github.com/saikrishna321/OSINT-Tool"
    ["XSS-Tools"]="https://github.com/An0nUD4Y/XSS-Tools"
    ["D-TECT"]="https://github.com/An0nUD4Y/D-TECT"
    ["TermuxHackingTools"]="https://github.com/Techzindia/TermuxHackingTools"
    ["OSINT-Toolkit"]="https://github.com/saikrishna321/OSINT-Toolkit"
    ["Hacking-Tools"]="https://github.com/An0nUD4Y/Hacking-Tools"
    ["Phishing-Toolkit"]="https://github.com/Techzindia/Phishing-Toolkit"
    ["Social-Engineering-Toolkit"]="https://github.com/trustedsec/social-engineer-toolkit"
    ["Recon-ng"]="https://github.com/lanmaster53/recon-ng"
    ["SpiderFoot"]="https://github.com/smicallef/spiderfoot"
    ["Amass"]="https://github.com/owasp-amass/amass"
    ["Sublist3r"]="https://github.com/aboul3la/Sublist3r"
    ["Nmap"]="https://github.com/nmap/nmap"
    ["Gobuster"]="https://github.com/OJ/gobuster"
    ["Nikto"]="https://github.com/sullo/nikto"
    ["Dirsearch"]="https://github.com/maurosoria/dirsearch"
    ["Wfuzz"]="https://github.com/xmendez/wfuzz"
    ["XSStrike"]="https://github.com/s0md3v/XSStrike"
    ["SQLMap"]="https://github.com/sqlmapproject/sqlmap"
    ["WPScan"]="https://github.com/wpscanteam/wpscan"
    ["Burp-Suite"]="https://github.com/snoopysecurity/burp-suite-community-edition"
    ["OWASP-ZAP"]="https://github.com/zaproxy/zaproxy"
    ["BeEF"]="https://github.com/beefproject/beef"
    ["Cewl"]="https://github.com/digininja/CeWL"
    ["Hashcat"]="https://github.com/hashcat/hashcat"
    ["John-the-Ripper"]="https://github.com/openwall/john"
    ["Mimikatz"]="https://github.com/gentilkiwi/mimikatz"
    ["Empire"]="https://github.com/BC-SECURITY/Empire"
    ["BloodHound"]="https://github.com/BloodHoundAD/BloodHound"
    ["CrackMapExec"]="https://github.com/Porchetta-Industries/CrackMapExec"
    ["Responder"]="https://github.com/lgandx/Responder"
    ["Impacket"]="https://github.com/SecureAuthCorp/impacket"
    ["Kali-Linux"]="https://github.com/OffensiveSecurity/kali-linux"
    ["Metasploit-Framework"]="https://github.com/rapid7/metasploit-framework"
    ["Aircrack-ng"]="https://github.com/aircrack-ng/aircrack-ng"
    ["Hydra"]="https://github.com/vanhauser-thc/thc-hydra"
    ["Wireshark"]="https://github.com/wireshark/wireshark"
    ["Tcpdump"]="https://github.com/the-tcpdump-group/tcpdump"
    ["Scapy"]="https://github.com/secdev/scapy"
    ["Bettercap"]="https://github.com/bettercap/bettercap"
    ["Ettercap"]="https://github.com/Ettercap/ettercap"
    ["Nessus"]="https://github.com/tenable/nessus"
    ["OpenVAS"]="https://github.com/greenbone/openvas"
    ["GVM"]="https://github.com/greenbone/gvm"
    ["Nuclei"]="https://github.com/projectdiscovery/nuclei"
    ["Subfinder"]="https://github.com/projectdiscovery/subfinder"
    ["Naabu"]="https://github.com/projectdiscovery/naabu"
    ["Dnsx"]="https://github.com/projectdiscovery/dnsx"
    ["Httpx"]="https://github.com/projectdiscovery/httpx"
    ["Proxify"]="https://github.com/projectdiscovery/proxify"
    ["Notify"]="https://github.com/projectdiscovery/notify"
    ["Chaos"]="https://github.com/projectdiscovery/chaos-client"
    ["Katana"]="https://github.com/projectdiscovery/katana"
    ["Interactsh"]="https://github.com/projectdiscovery/interactsh"
    ["Cloudlist"]="https://github.com/projectdiscovery/cloudlist"
    ["Uncover"]="https://github.com/projectdiscovery/uncover"
    ["Pdtm"]="https://github.com/projectdiscovery/pdtm"
    
    # Explotación Web (25 herramientas)
    ["XSS-Tools"]="https://github.com/faizann24/XssPy"
    ["D-TECT"]="https://github.com/shawarkhanethicalhacker/D-TECT"
    ["XSStrike"]="https://github.com/s0md3v/XSStrike"
    ["SQLMap"]="https://github.com/sqlmapproject/sqlmap"
    ["WPScan"]="https://github.com/wpscanteam/wpscan"
    ["Burp-Suite"]="https://github.com/PortSwigger/burp-suite-community"
    ["OWASP-ZAP"]="https://github.com/zaproxy/zaproxy"
    ["BeEF"]="https://github.com/beefproject/beef"
    ["Commix"]="https://github.com/commixproject/commix"
    ["WPSeku"]="https://github.com/m4ll0k/WPSeku"
    ["Joomscan"]="https://github.com/rezasp/joomscan"
    ["Wapiti"]="https://github.com/wapiti-scanner/wapiti"
    ["W3af"]="https://github.com/andresriancho/w3af"
    ["Arachni"]="https://github.com/Arachni/arachni"
    ["Golismero"]="https://github.com/golismero/golismero"
    ["Vega"]="https://github.com/subgraph/Vega"
    ["Nikto"]="https://github.com/sullo/nikto"
    ["Skipfish"]="https://github.com/spinkham/skipfish"
    ["Wfuzz"]="https://github.com/xmendez/wfuzz"
    ["Joomla-Scanner"]="https://github.com/drego85/Joomla-Scanner"
    ["Drupal-Scan"]="https://github.com/r3dxpl0it/Drupal-Scan"
    ["Wordpress-Scanner"]="https://github.com/wpscanteam/wpscan"
    ["Joomla-Vulnerability-Scanner"]="https://github.com/rezasp/joomscan"
    ["Drupal-Vulnerability-Scanner"]="https://github.com/droope/droopescan"
    
    # Explotación y Post-Explotación (30 herramientas)
    ["Metasploit"]="https://github.com/rapid7/metasploit-framework"
    ["Empire"]="https://github.com/BC-SECURITY/Empire"
    ["Cobalt-Strike"]="https://github.com/rsmudge/cobalt-strike"
    ["Mimikatz"]="https://github.com/gentilkiwi/mimikatz"
    ["CrackMapExec"]="https://github.com/byt3bl33d3r/CrackMapExec"
    ["Impacket"]="https://github.com/SecureAuthCorp/impacket"
    ["Responder"]="https://github.com/lgandx/Responder"
    ["PowerSploit"]="https://github.com/PowerShellMafia/PowerSploit"
    ["BloodHound"]="https://github.com/BloodHoundAD/BloodHound"
    ["PrivExchange"]="https://github.com/dirkjanm/PrivExchange"
    ["Rubeus"]="https://github.com/GhostPack/Rubeus"
    ["SharpHound"]="https://github.com/BloodHoundAD/SharpHound"
    ["Seatbelt"]="https://github.com/GhostPack/Seatbelt"
    ["SharpUp"]="https://github.com/GhostPack/SharpUp"
    ["SharpView"]="https://github.com/tevora-threat/SharpView"
    ["SharpHound3"]="https://github.com/BloodHoundAD/SharpHound3"
    ["SharpDPAPI"]="https://github.com/GhostPack/SharpDPAPI"
    ["SharpDump"]="https://github.com/GhostPack/SharpDump"
    ["SharpWMI"]="https://github.com/GhostPack/SharpWMI"
    ["SharpRoast"]="https://github.com/GhostPack/SharpRoast"
    ["SharpSploit"]="https://github.com/cobbr/SharpSploit"
    ["SharpHound2"]="https://github.com/BloodHoundAD/SharpHound2"
    ["SharpHound4"]="https://github.com/BloodHoundAD/SharpHound4"
    ["SharpHound5"]="https://github.com/BloodHoundAD/SharpHound5"
    ["SharpHound6"]="https://github.com/BloodHoundAD/SharpHound6"
    ["SharpHound7"]="https://github.com/BloodHoundAD/SharpHound7"
    ["SharpHound8"]="https://github.com/BloodHoundAD/SharpHound8"
    ["SharpHound9"]="https://github.com/BloodHoundAD/SharpHound9"
    ["SharpHound10"]="https://github.com/BloodHoundAD/SharpHound10"
    
    # Escaneo y Análisis de Red (20 herramientas)
    ["Nmap"]="https://github.com/nmap/nmap"
    ["Wireshark"]="https://github.com/wireshark/wireshark"
    ["Bettercap"]="https://github.com/bettercap/bettercap"
    ["Nessus"]="https://github.com/tenable/nessus"
    ["Masscan"]="https://github.com/robertdavidgraham/masscan"
    ["Zmap"]="https://github.com/zmap/zmap"
    ["Netdiscover"]="https://github.com/netdiscover-scanner/netdiscover"
    ["Netcat"]="https://github.com/diegocr/netcat"
    ["Hping"]="https://github.com/antirez/hping"
    ["Tcpdump"]="https://github.com/the-tcpdump-group/tcpdump"
    ["Tshark"]="https://github.com/wireshark/wireshark"
    ["Scapy"]="https://github.com/secdev/scapy"
    ["Netcat"]="https://github.com/diegocr/netcat"
    ["Netcat-traditional"]="https://github.com/diegocr/netcat"
    ["Netcat-openbsd"]="https://github.com/diegocr/netcat"
    ["Netcat-gnu"]="https://github.com/diegocr/netcat"
    ["Netcat-bsd"]="https://github.com/diegocr/netcat"
    ["Netcat-debian"]="https://github.com/diegocr/netcat"
    ["Netcat-ubuntu"]="https://github.com/diegocr/netcat"
    ["Netcat-kali"]="https://github.com/diegocr/netcat"
    
    # Hacking de Juegos (20 herramientas)
    ["Metasploit-Framework"]="https://github.com/rapid7/metasploit-framework"
    ["Game-Hacking"]="https://github.com/dsasmblr/game-hacking"
    ["Game-Hacking-1"]="https://github.com/Mehardeep/game-hacking-1"
    ["Cheat-Engine"]="https://github.com/dsasmblr/cheat-engine"
    ["Squalr"]="https://github.com/Squalr/Squalr"
    ["MungPlex"]="https://github.com/CosmoCortney/MungPlex"
    ["GTA-SA-Cheats"]="https://github.com/Edward-P-Astbury/gta_sa_cheats"
    ["Payback2-CHEATus"]="https://github.com/ABJ4403/Payback2_CHEATus"
    ["SimCity-Cheat"]="https://github.com/souforte/SimCity-Cheat"
    ["Warzone2100"]="https://github.com/Warzone2100/warzone2100"
    ["StellarRealms"]="https://github.com/nagten/StellarRealms"
    ["Hacking-Online-Games"]="https://github.com/dsasmblr/hacking-online-games"
    ["Reloaded-Memory-SigScan"]="https://github.com/Reloaded-Project/Reloaded.Memory.SigScan"
    ["GH-D3D11-Hook"]="https://github.com/guided-hacking/GH_D3D11_Hook"
    ["Game-Hacks"]="https://github.com/topics/game-hacks"
    ["Game-Hack-Menu"]="https://github.com/topics/game-hack-menu"
    ["Hacking-Tools"]="https://github.com/topics/hacking-tools"
    ["Game-Tweaks"]="https://github.com/topics/game-tweaks"
    ["GameGuardian"]="https://github.com/GameGuardian/GameGuardian"
    ["GameCIH"]="https://github.com/GameCIH/GameCIH"
    ["GameKiller"]="https://github.com/GameKiller/GameKiller"
    ["GameGuard"]="https://github.com/GameGuard/GameGuard"
    ["GameHack"]="https://github.com/GameHack/GameHack"
    ["GameTool"]="https://github.com/GameTool/GameTool"
    ["GameMaster"]="https://github.com/GameMaster/GameMaster"
    ["GameWarden"]="https://github.com/GameWarden/GameWarden"
    
    # Hacking de Aplicaciones Móviles (20 herramientas)
    ["WhatsAppHacking"]="https://github.com/WhatsAppHacking/WhatsAppHacking"
    ["Android-Studio"]="https://github.com/android/studio"
    ["APKTool"]="https://github.com/iBotPeaches/Apktool"
    ["Dex2Jar"]="https://github.com/pxb1988/dex2jar"
    ["Frida"]="https://github.com/frida/frida"
    ["Objection"]="https://github.com/sensepost/objection"
    ["MobSF"]="https://github.com/MobSF/Mobile-Security-Framework-MobSF"
    ["JADX"]="https://github.com/skylot/jadx"
    ["Ghidra"]="https://github.com/NationalSecurityAgency/ghidra"
    ["Radare2"]="https://github.com/radareorg/radare2"
    ["APK-MITM"]="https://github.com/shroudedcode/apk-mitm"
    ["APKLeaks"]="https://github.com/dwisiswant0/apkleaks"
    ["APK-Downloader"]="https://github.com/APK-Downloader/APK-Downloader"
    ["Android-Tools"]="https://github.com/android/tools"
    ["Android-SDK"]="https://github.com/android/sdk"
    ["Android-NDK"]="https://github.com/android/ndk"
    ["Android-Platform"]="https://github.com/android/platform"
    ["Android-Framework"]="https://github.com/android/framework"
    ["Android-System"]="https://github.com/android/system"
    ["Android-Kernel"]="https://github.com/android/kernel"
    
    # Herramientas de Hacking Ético (50 herramientas)
    ["Metasploit-Framework"]="https://github.com/rapid7/metasploit-framework"
    ["Nmap"]="https://github.com/nmap/nmap"
    ["SQLMap"]="https://github.com/sqlmapproject/sqlmap"
    ["Mimikatz"]="https://github.com/gentilkiwi/mimikatz"
    ["Aircrack-ng"]="https://github.com/aircrack-ng/aircrack-ng"
    ["Wireshark"]="https://github.com/wireshark/wireshark"
    ["Burp-Suite"]="https://github.com/snoopysecurity/burp-suite-community-edition"
    ["Empire"]="https://github.com/BC-SECURITY/Empire"
    ["Hydra"]="https://github.com/vanhauser-thc/thc-hydra"
    ["Bettercap"]="https://github.com/bettercap/bettercap"
    ["John-the-Ripper"]="https://github.com/openwall/john"
    ["Hashcat"]="https://github.com/hashcat/hashcat"
    ["OWASP-ZAP"]="https://github.com/zaproxy/zaproxy"
    ["Sublist3r"]="https://github.com/aboul3la/Sublist3r"
    ["Nuclei"]="https://github.com/projectdiscovery/nuclei"
    ["Gobuster"]="https://github.com/OJ/gobuster"
    ["XSStrike"]="https://github.com/s0md3v/XSStrike"
    ["Social-Engineering-Toolkit"]="https://github.com/trustedsec/social-engineer-toolkit"
    ["GoPhish"]="https://github.com/gophish/gophish"
    ["BloodHound"]="https://github.com/BloodHoundAD/BloodHound"
    ["CrackMapExec"]="https://github.com/Porchetta-Industries/CrackMapExec"
    ["Responder"]="https://github.com/lgandx/Responder"
    ["Impacket"]="https://github.com/SecureAuthCorp/impacket"
    ["Recon-ng"]="https://github.com/lanmaster53/recon-ng"
    ["SpiderFoot"]="https://github.com/smicallef/spiderfoot"
    ["Amass"]="https://github.com/owasp-amass/amass"
    ["Fierce"]="https://github.com/mschwager/fierce"
    ["Subfinder"]="https://github.com/projectdiscovery/subfinder"
    ["Dirsearch"]="https://github.com/maurosoria/dirsearch"
    ["Nikto"]="https://github.com/sullo/nikto"
    ["Skipfish"]="https://github.com/spinkham/skipfish"
    ["Wfuzz"]="https://github.com/xmendez/wfuzz"
    ["Sqlninja"]="https://github.com/sqlninja/sqlninja"
    ["Nessus"]="https://github.com/tenable/nessus"
    ["Zphisher"]="https://github.com/htr-tech/zphisher"
    ["Maltego"]="https://github.com/paterva/maltego"
    ["Osmedeus"]="https://github.com/j3ssie/Osmedeus"
    ["Red-Team-Attack-Lab"]="https://github.com/infosecn1nja/Red-Teaming-Toolkit"
    ["Vega"]="https://github.com/subgraph/Vega"
    ["Cobalt-Strike"]="https://github.com/Fortra/Cobalt-Strike"
    ["Mudge-Password-Tools"]="https://github.com/mudgen/"
    ["Cewl"]="https://github.com/digininja/CeWL"
    ["T50"]="https://github.com/s0lst1c3/t50"
    ["Nginx-Helper"]="https://github.com/rbenv/nginx_helper"
    ["Crackstation"]="https://github.com/crackstation/"
    ["ProxyChains"]="https://github.com/haad/proxychains"
    ["GoReverseShell"]="https://github.com/danielmiessler/GoReverseShell"
    ["Scapy"]="https://github.com/secdev/scapy"
    ["Tcpdump"]="https://github.com/the-tcpdump-group/tcpdump"
    ["Ettercap"]="https://github.com/Ettercap/ettercap"
    ["OpenVAS"]="https://github.com/greenbone/openvas"
    ["GVM"]="https://github.com/greenbone/gvm"
    ["Naabu"]="https://github.com/projectdiscovery/naabu"
    ["Dnsx"]="https://github.com/projectdiscovery/dnsx"
    ["Httpx"]="https://github.com/projectdiscovery/httpx"
    ["Proxify"]="https://github.com/projectdiscovery/proxify"
    ["Notify"]="https://github.com/projectdiscovery/notify"
    ["Chaos"]="https://github.com/projectdiscovery/chaos-client"
    ["Katana"]="https://github.com/projectdiscovery/katana"
    ["Interactsh"]="https://github.com/projectdiscovery/interactsh"
    ["Cloudlist"]="https://github.com/projectdiscovery/cloudlist"
    ["Uncover"]="https://github.com/projectdiscovery/uncover"
    ["Pdtm"]="https://github.com/projectdiscovery/pdtm"
)

# Required Dependencies and Tools
declare -a REQUIRED_DEPENDENCIES=(
    "python3"
    "git"
    "java"
    "ruby"
    "perl"
    "gcc"
    "make"
    "wget"
    "curl"
)

declare -a REQUIRED_TOOLS=(
    "nmap"
    "sqlmap"
    "metasploit-framework"
    "wireshark"
    "burpsuite"
    "aircrack-ng"
)

# Función mejorada para mostrar la pantalla de carga
show_loading_screen() {
    local total_steps=7
    local current_step=0
    
    # Paso 1: Inicialización del sistema
    clear
    echo -e "${THEMES['matrix']}"
    echo "  ███████╗ ██████╗ ██╗  ██╗██╗██╗  ██╗"
    echo "  ██╔════╝██╔═══██╗██║ ██╔╝██║╚██╗██╔╝"
    echo "  ███████╗██║   ██║█████╔╝ ██║ ╚███╔╝ "
    echo "  ╚════██║██║   ██║██╔═██╗ ██║ ██╔██╗ "
    echo "  ███████║╚██████╔╝██║  ██╗██║██╔╝ ██╗"
    echo "  ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝"
    echo -e "${COLORS['NC']}"
    echo -e "${COLORS['CYAN']}Professional Ethical Hacking Environment v$VERSION${COLORS['NC']}"
    echo -e "${COLORS['YELLOW']}Copyright (c) 2024 SOKIX Security Team${COLORS['NC']}"
    echo
    
    show_system_info
    
    current_step=$((current_step + 1))
    show_progress "Inicializando sistema" $current_step $total_steps
    
    # Paso 2: Autodiagnóstico
    perform_diagnostic
    current_step=$((current_step + 1))
    show_progress "Diagnóstico completado" $current_step $total_steps
    
    # Paso 3: Descargando herramientas
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['DOWNLOAD']} Descargando herramientas... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    local total_tools=${#GITHUB_REPOS[@]}
    local current_tool=0
    
    # Crear directorio de herramientas si no existe
    mkdir -p "$TOOLS_DIR"
    
    for tool in "${!GITHUB_REPOS[@]}"; do
        current_tool=$((current_tool + 1))
        local progress=$((current_tool * 100 / total_tools))
        
        # Mostrar barra de progreso
        echo -ne "\r${COLORS['CYAN']}["
        for ((i=0; i<50; i++)); do
            if [ $i -lt $((progress / 2)) ]; then
                echo -ne "${ANIMATIONS['downloading'][$((i % ${#ANIMATIONS['downloading'][@]}))]}"
            else
                echo -ne " "
            fi
        done
        echo -ne "] Descargando $tool...${COLORS['NC']}"
        
        # Instalar la herramienta
        install_tool "$tool"
        
        # Verificar si la instalación fue exitosa
        if [ $? -eq 0 ]; then
            echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} $tool instalado correctamente${COLORS['NC']}"
        else
            echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Error al instalar $tool${COLORS['NC']}"
        fi
    done
    
    current_step=$((current_step + 1))
    show_progress "Herramientas descargadas" $current_step $total_steps
    
    # Paso 4: Cargando módulos con animación
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['GEAR']} Cargando módulos del sistema... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    for module in "${MODULES[@]}"; do
        show_module_loading "$module"
        load_module "$module"
    done
    
    current_step=$((current_step + 1))
    show_progress "Módulos cargados" $current_step $total_steps
    
    # Paso 5: Verificando dependencias con animación
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['PACKAGE']} Verificando dependencias... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    check_dependencies
    
    current_step=$((current_step + 1))
    show_progress "Dependencias verificadas" $current_step $total_steps
    
    # Paso 6: Configurando entorno con animación
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['WRENCH']} Configurando entorno... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    setup_environment
    
    current_step=$((current_step + 1))
    show_progress "Entorno configurado" $current_step $total_steps
    
    # Paso 7: Inicializando herramientas con animación
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['TOOLS']} Inicializando herramientas... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    initialize_tools
    
    current_step=$((current_step + 1))
    show_progress "Herramientas inicializadas" $current_step $total_steps
    
    # Paso 8: Finalización con resumen
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['CHART']} Resumen del sistema: ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    show_system_summary
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"
    echo -e "${COLORS['GREEN']}${UNICODE['SUCCESS']} Toolkit inicializado correctamente${COLORS['NC']}"
    sleep 2
}

# Función para mostrar información del sistema
show_system_info() {
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_TOP']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['TERMINAL']} Información del Sistema ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    local os_info=$(uname -a)
    local cpu_info=$(cat /proc/cpuinfo | grep "model name" | head -n 1 | cut -d ":" -f 2)
    local mem_info=$(free -h | grep Mem | awk '{print $2}')
    local disk_info=$(df -h / | tail -n 1 | awk '{print $2}')
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Sistema Operativo:${COLORS['NC']} $os_info ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Procesador:${COLORS['NC']} $cpu_info ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Memoria:${COLORS['NC']} $mem_info ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Disco:${COLORS['NC']} $disk_info ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"
}

# Función para realizar el diagnóstico del sistema
perform_diagnostic() {
    local total_checks=10
    local current_check=0
    local success_count=0
    local warning_count=0
    local error_count=0

    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_TOP']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['MAGNIFIER']} Iniciando diagnóstico del sistema... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"

    # 1. Verificar sistema operativo
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando sistema operativo...${COLORS['NC']}"
    if check_os; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Sistema operativo compatible${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Sistema operativo no compatible${COLORS['NC']}"
    fi

    # 2. Verificar memoria RAM
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando memoria RAM...${COLORS['NC']}"
    if check_memory; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Memoria RAM suficiente${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} Memoria RAM insuficiente${COLORS['NC']}"
    fi

    # 3. Verificar almacenamiento
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando almacenamiento...${COLORS['NC']}"
    if check_storage; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Almacenamiento suficiente${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} Almacenamiento insuficiente${COLORS['NC']}"
    fi

    # 4. Verificar CPU
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando CPU...${COLORS['NC']}"
    if check_cpu; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} CPU compatible${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} CPU no recomendada${COLORS['NC']}"
    fi

    # 5. Verificar red
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando conexión de red...${COLORS['NC']}"
    if check_network; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Conexión de red estable${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Problemas de conexión${COLORS['NC']}"
    fi

    # 6. Verificar dependencias
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando dependencias...${COLORS['NC']}"
    if check_dependencies; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Dependencias instaladas${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Faltan dependencias${COLORS['NC']}"
    fi

    # 7. Verificar permisos
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando permisos...${COLORS['NC']}"
    if check_permissions; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Permisos correctos${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Problemas de permisos${COLORS['NC']}"
    fi

    # 8. Verificar directorios
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando directorios...${COLORS['NC']}"
    if check_directories; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Directorios correctos${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Problemas con directorios${COLORS['NC']}"
    fi

    # 9. Verificar herramientas
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando herramientas...${COLORS['NC']}"
    if check_tools; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Herramientas instaladas${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} Faltan algunas herramientas${COLORS['NC']}"
    fi

    # 10. Verificar configuración
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando configuración...${COLORS['NC']}"
    if check_configuration; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Configuración correcta${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} Configuración incompleta${COLORS['NC']}"
    fi

    # Mostrar resumen
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}Resumen del diagnóstico:${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}Éxitos: $success_count${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Advertencias: $warning_count${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['RED']}Errores: $error_count${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"

    # Retornar estado
    if [ $error_count -gt 0 ]; then
        return 1
    elif [ $warning_count -gt 0 ]; then
        return 2
    else
        return 0
    fi
}

# Función para verificar el sistema operativo
check_os() {
    case "$(uname -s)" in
        Linux)
            # Verificar distribución
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                case "$ID" in
                    ubuntu|debian|kali)
                        return 0
                        ;;
                    *)
                        return 1
                        ;;
                esac
            fi
            ;;
        Darwin)
            # Verificar versión de macOS
            if [ "$(sw_vers -productVersion | cut -d. -f1)" -ge 10 ]; then
                return 0
            fi
            ;;
        MINGW*|MSYS*|CYGWIN*)
            # Verificar versión de Windows
            if [ "$(uname -r | cut -d- -f1)" -ge 10 ]; then
                return 0
            fi
            ;;
    esac
    return 1
}

# Función para verificar memoria RAM
check_memory() {
    local min_ram=4000  # 4GB en MB
    local recommended_ram=8000  # 8GB en MB
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    
    if [ "$total_ram" -ge "$recommended_ram" ]; then
        return 0
    elif [ "$total_ram" -ge "$min_ram" ]; then
        echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} Memoria RAM insuficiente (${total_ram}MB). Se recomiendan al menos ${recommended_ram}MB${COLORS['NC']}"
        return 1
    else
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} Memoria RAM insuficiente (${total_ram}MB). Mínimo requerido: ${min_ram}MB${COLORS['NC']}"
        return 2
    fi
}

# Función para verificar almacenamiento
check_storage() {
    local min_storage=20000  # 20GB en MB
    local available_storage=$(df -m / | awk 'NR==2 {print $4}')
    
    if [ "$available_storage" -ge "$min_storage" ]; then
        return 0
    fi
    return 1
}

# Función para verificar CPU
check_cpu() {
    local min_cores=2
    local cores=$(nproc)
    
    if [ "$cores" -ge "$min_cores" ]; then
        return 0
    fi
    return 1
}

# Función para verificar red
check_network() {
    if ping -c 1 google.com &> /dev/null; then
        return 0
    fi
    return 1
}

# Función para verificar directorios
check_directories() {
    local required_dirs=(
        "$TOOLS_DIR"
        "$MODULES_DIR"
        "$SCRIPTS_DIR"
        "$CACHE_DIR"
        "$TEMP_DIR"
        "$BACKUP_DIR"
        "$REPORTS_DIR"
    )
    
    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir" || return 1
        fi
        if [ ! -w "$dir" ]; then
            return 1
        fi
    done
    return 0
}

# Función para verificar configuración
check_configuration() {
    if [ ! -f "$CONFIG_FILE" ]; then
        create_default_config || return 1
    fi
    
    # Verificar permisos del archivo de configuración
    if [ ! -r "$CONFIG_FILE" ] || [ ! -w "$CONFIG_FILE" ]; then
        return 1
    fi
    
    return 0
}

# Función para mostrar la carga de módulos con animación
show_module_loading() {
    local module=$1
    echo -ne "\r${COLORS['CYAN']}["
    for ((i=0; i<50; i++)); do
        echo -ne "${ANIMATIONS['processing'][$((i % ${#ANIMATIONS['processing'][@]}))]}"
    done
    echo -ne "] Cargando módulo: $module...${COLORS['NC']}"
    sleep 0.3
}

# Función para mostrar resumen del sistema
show_system_summary() {
    local total_modules=${#MODULES[@]}
    local total_tools=$(ls "$TOOLS_DIR" | wc -l)
    local system_status="OK"
    local security_status="OK"
    local performance_status="OK"
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Módulos cargados:${COLORS['NC']} $total_modules ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Herramientas instaladas:${COLORS['NC']} $total_tools ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Estado del sistema:${COLORS['NC']} $system_status ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Estado de seguridad:${COLORS['NC']} $security_status ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Rendimiento:${COLORS['NC']} $performance_status ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
}

# Funciones de diagnóstico específicas
check_system() {
    # Check system requirements
    if [ "$(uname)" != "Linux" ]; then
        echo -e "${COLORS['RED']}Warning: This toolkit is optimized for Linux systems${COLORS['NC']}"
        return 1
    fi
    return 0
}

check_network() {
    # Check network connectivity
    if ! ping -c 1 google.com &> /dev/null; then
        echo -e "${COLORS['RED']}No internet connection${COLORS['NC']}"
        return 1
    fi
    return 0
}

check_security() {
    # Check security settings
    if [ "$(id -u)" != "0" ]; then
        echo -e "${COLORS['YELLOW']}Running without root privileges${COLORS['NC']}"
        return 1
    fi
    return 0
}

check_performance() {
    # Check system performance
    local load=$(uptime | awk '{print $(NF-2)}' | tr -d ',')
    if (( $(echo "$load > 2.0" | bc -l) )); then
        echo -e "${COLORS['YELLOW']}High system load detected${COLORS['NC']}"
        return 1
    fi
    return 0
}

check_dependencies() {
    for dep in "${REQUIRED_DEPENDENCIES[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} $dep no está instalado${COLORS['NC']}"
            install_dependency "$dep"
        fi
    done
}

check_tools() {
    local missing_tools=()
    local installed_tools=()
    
    for tool in "${REQUIRED_TOOLS[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        else
            installed_tools+=("$tool")
        fi
    done
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} Herramientas faltantes: ${missing_tools[*]}${COLORS['NC']}"
        echo -e "${COLORS['CYAN']}Intentando instalar herramientas faltantes...${COLORS['NC']}"
        
        for tool in "${missing_tools[@]}"; do
            install_dependency "$tool"
        done
        
        # Verificar nuevamente después de la instalación
        local still_missing=()
        for tool in "${missing_tools[@]}"; do
            if ! command -v "$tool" &> /dev/null; then
                still_missing+=("$tool")
            fi
        done
        
        if [ ${#still_missing[@]} -gt 0 ]; then
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se pudieron instalar las siguientes herramientas: ${still_missing[*]}${COLORS['NC']}"
            return 1
        fi
    fi
    
    echo -e "${COLORS['GREEN']}${UNICODE['SUCCESS']} Herramientas instaladas: ${installed_tools[*]}${COLORS['NC']}"
    return 0
}

check_permissions() {
    local log_dir=$(dirname "$LOG_FILE")
    
    # Verificar y crear directorio de logs si no existe
    if [ ! -d "$log_dir" ]; then
        mkdir -p "$log_dir" || {
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se pudo crear el directorio de logs${COLORS['NC']}"
            return 1
        }
    fi
    
    # Verificar permisos del directorio de logs
    if [ ! -w "$log_dir" ]; then
        echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} Intentando corregir permisos del directorio de logs...${COLORS['NC']}"
        sudo chown -R "$(whoami)" "$log_dir" || {
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se pudo corregir los permisos del directorio de logs${COLORS['NC']}"
            return 1
        }
    }
    
    # Verificar y crear archivo de log si no existe
    if [ ! -f "$LOG_FILE" ]; then
        touch "$LOG_FILE" || {
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se pudo crear el archivo de log${COLORS['NC']}"
            return 1
        }
    }
    
    # Verificar permisos del archivo de log
    if [ ! -w "$LOG_FILE" ]; then
        echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} Intentando corregir permisos del archivo de log...${COLORS['NC']}"
        sudo chown "$(whoami)" "$LOG_FILE" || {
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se pudo corregir los permisos del archivo de log${COLORS['NC']}"
            return 1
        }
    }
    
    return 0
}

# Función para mostrar progreso con animación
show_progress() {
    local message=$1
    local current=$2
    local total=$3
    local width=50
    local progress=$((current * width / total))
    local remaining=$((width - progress))
    local hacking_animation=${ANIMATIONS['hacking']}
    
    echo -ne "\r${COLORS['CYAN']}["
    for ((i=0; i<progress; i++)); do
        local animation_index=$((i % ${#ANIMATIONS['hacking']}))
        echo -ne "${ANIMATIONS['hacking']:$animation_index:1}"
    done
    for ((i=0; i<remaining; i++)); do
        echo -ne " "
    done
    echo -ne "] ${message}...${COLORS['NC']}"
}

# Función para cargar módulos
load_module() {
    local module=$1
    local config_file="${MODULE_CONFIGS[$module]}"
    
    if [ -f "$CONFIG_DIR/$config_file" ]; then
        source "$CONFIG_DIR/$config_file"
        echo -e "${COLORS['GREEN']}${UNICODE['SUCCESS']} Módulo $module cargado${COLORS['NC']}"
    else
        echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} Configuración no encontrada para $module${COLORS['NC']}"
    fi
}

# Función para instalar dependencias
install_dependency() {
    local dep=$1
    echo -e "${COLORS['CYAN']}Instalando $dep...${COLORS['NC']}"
    
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y "$dep" || {
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} Error al instalar $dep con apt-get${COLORS['NC']}"
            return 1
        }
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y "$dep" || {
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} Error al instalar $dep con yum${COLORS['NC']}"
            return 1
        }
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm "$dep" || {
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} Error al instalar $dep con pacman${COLORS['NC']}"
            return 1
        }
    else
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se pudo determinar el gestor de paquetes${COLORS['NC']}"
        return 1
    fi
    
    return 0
}

# Función para configurar el entorno
setup_environment() {
    # Configurar variables de entorno
    export PATH="$PATH:$TOOLS_DIR/bin"
    export PYTHONPATH="$PYTHONPATH:$TOOLS_DIR/python"
    
    # Crear directorios necesarios
    mkdir -p "$TOOLS_DIR/bin"
    mkdir -p "$TOOLS_DIR/python"
    mkdir -p "$TOOLS_DIR/ruby"
    mkdir -p "$TOOLS_DIR/perl"
    mkdir -p "$TOOLS_DIR/java"
    
    # Configurar permisos
    chmod -R 755 "$TOOLS_DIR"
    chown -R "$(whoami)" "$TOOLS_DIR"
}

# Función para inicializar herramientas
initialize_tools() {
    local tools=($(ls "$TOOLS_DIR"))
    local total_tools=${#tools[@]}
    local current_tool=0
    local failed_tools=()
    
    for tool in "${tools[@]}"; do
        current_tool=$((current_tool + 1))
        local progress=$((current_tool * 100 / total_tools))
        
        echo -ne "\r${COLORS['CYAN']}["
        for ((i=0; i<50; i++)); do
            if [ $i -lt $((progress / 2)) ]; then
                echo -ne "${ANIMATIONS['downloading'][$((i % ${#ANIMATIONS['downloading'][@]}))]}"
            else
                echo -ne " "
            fi
        done
        echo -ne "] Inicializando $tool...${COLORS['NC']}"
        
        if ! install_tool "$tool"; then
            failed_tools+=("$tool")
        fi
    done
    
    # Mostrar resumen de inicialización
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}Resumen de inicialización:${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}Herramientas inicializadas: $((total_tools - ${#failed_tools[@]}))${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    if [ ${#failed_tools[@]} -gt 0 ]; then
        echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['RED']}Herramientas fallidas: ${failed_tools[*]}${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    fi
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"
}

# Función para encontrar el archivo principal de una herramienta
find_main_file() {
    local tool_dir=$1
    local patterns=(
        "*.sh"
        "*.py"
        "*.rb"
        "*.jar"
        "*.exe"
        "main.*"
        "run.*"
        "start.*"
        "init.*"
        "setup.*"
    )
    
    for pattern in "${patterns[@]}"; do
        local file=$(find "$tool_dir" -type f -name "$pattern" | head -n 1)
        if [ -n "$file" ]; then
            echo "$file"
            return 0
        fi
    done
    
    return 1
}

# Función para ejecutar herramientas
run_tool() {
    local tool_name=$1
    local tool_dir="$TOOLS_DIR/$tool_name"
    shift  # Eliminar el primer argumento (nombre de la herramienta)
    local args=("$@")  # Resto de argumentos
    
    if [ ! -d "$tool_dir" ]; then
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} La herramienta $tool_name no está instalada${COLORS['NC']}"
        return 1
    }
    
    # Verificar si la herramienta ya está en ejecución
    if pgrep -f "$tool_name" > /dev/null; then
        echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} $tool_name ya está en ejecución${COLORS['NC']}"
        return 1
    }
    
    echo -e "${COLORS['CYAN']}${UNICODE['TERMINAL']} Ejecutando $tool_name...${COLORS['NC']}"
    
    # Buscar el archivo principal
    local main_file=$(find_main_file "$tool_dir")
    
    if [ -z "$main_file" ]; then
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se encontró el archivo principal de $tool_name${COLORS['NC']}"
        return 1
    }
    
    # Obtener la extensión del archivo
    local extension="${main_file##*.}"
    
    # Hacer el archivo ejecutable si es necesario
    if [[ "$extension" == "sh" || "$extension" == "py" || "$extension" == "rb" ]]; then
        chmod +x "$main_file" || {
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se pudo hacer ejecutable el archivo principal${COLORS['NC']}"
            return 1
        }
    }
    
    # Ejecutar el archivo según su extensión
    case "$extension" in
        "sh")
            cd "$(dirname "$main_file")" && ./"$(basename "$main_file")" "${args[@]}"
            ;;
        "py")
            cd "$(dirname "$main_file")" && python3 "$(basename "$main_file")" "${args[@]}"
            ;;
        "rb")
            cd "$(dirname "$main_file")" && ruby "$(basename "$main_file")" "${args[@]}"
            ;;
        "jar")
            cd "$(dirname "$main_file")" && java -jar "$(basename "$main_file")" "${args[@]}"
            ;;
        "exe")
            cd "$(dirname "$main_file")" && wine "$(basename "$main_file")" "${args[@]}"
            ;;
        *)
            cd "$(dirname "$main_file")" && ./"$(basename "$main_file")" "${args[@]}"
            ;;
    esac
    
    # Verificar si la ejecución fue exitosa
    if [ $? -ne 0 ]; then
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} Error al ejecutar $tool_name${COLORS['NC']}"
        return 1
    fi
    
    return 0
}

# Función para verificar si una herramienta está instalada
is_tool_installed() {
    local tool_name=$1
    local tool_dir="$TOOLS_DIR/$tool_name"
    
    if [ -d "$tool_dir" ]; then
        # Verificar si hay un archivo ejecutable principal
        local main_file=$(find_main_file "$tool_dir")
        if [ -n "$main_file" ] && [ -x "$main_file" ]; then
            return 0
        fi
    fi
    return 1
}

# Función para instalar herramientas
install_tool() {
    local tool_name=$1
    local tool_dir="$TOOLS_DIR/$tool_name"
    
    # Verificar si ya está instalada
    if is_tool_installed "$tool_name"; then
        echo -e "${COLORS['GREEN']}${UNICODE['SUCCESS']} $tool_name ya está instalada${COLORS['NC']}"
        return 0
    fi
    
    echo -e "${COLORS['CYAN']}Instalando $tool_name...${COLORS['NC']}"
    
    # Obtener el repositorio de GitHub
    local repo_url="${GITHUB_REPOS[$tool_name]}"
    if [ -z "$repo_url" ]; then
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se encontró el repositorio de GitHub para $tool_name${COLORS['NC']}"
        return 1
    fi
    
    # Crear directorio para la herramienta
    mkdir -p "$tool_dir" || {
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} No se pudo crear el directorio para $tool_name${COLORS['NC']}"
        return 1
    }
    
    # Clonar repositorio
    echo -e "${COLORS['YELLOW']}Clonando repositorio: $repo_url${COLORS['NC']}"
    if ! git clone "$repo_url" "$tool_dir"; then
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} Error al clonar el repositorio de $tool_name${COLORS['NC']}"
        return 1
    fi
    
    # Instalar dependencias específicas de la herramienta
    if [ -f "$tool_dir/requirements.txt" ]; then
        echo -e "${COLORS['YELLOW']}Instalando dependencias de Python...${COLORS['NC']}"
        if ! pip install -r "$tool_dir/requirements.txt"; then
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} Error al instalar dependencias de Python para $tool_name${COLORS['NC']}"
            return 1
        fi
    fi
    
    if [ -f "$tool_dir/setup.py" ]; then
        echo -e "${COLORS['YELLOW']}Instalando con setup.py...${COLORS['NC']}"
        if ! (cd "$tool_dir" && python setup.py install); then
            echo -e "${COLORS['RED']}${UNICODE['ERROR']} Error al instalar con setup.py para $tool_name${COLORS['NC']}"
            return 1
        fi
    fi
    
    # Verificar la instalación
    if ! is_tool_installed "$tool_name"; then
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} La instalación de $tool_name no fue exitosa${COLORS['NC']}"
        return 1
    fi
    
    echo -e "${COLORS['GREEN']}${UNICODE['SUCCESS']} $tool_name instalada correctamente${COLORS['NC']}"
    return 0
}

# Función principal
main() {
    show_banner
    show_loading_screen
    
    while true; do
        show_main_menu
        read -r choice
        handle_tool_selection "$choice"
    done
}

# Iniciar el toolkit
main
