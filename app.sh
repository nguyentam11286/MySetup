#!/usr/bin/env bash
# Apache License 2.0
# Copyright (c) 2026
#
# Ubuntu workstation bootstrap installer.
# Target: Ubuntu 22.04 LTS (Jammy) and newer Debian-based Ubuntu releases.

set -Eeuo pipefail

readonly SCRIPT_NAME="$(basename "$0")"
readonly LOG_FILE="${LOG_FILE:-$HOME/ubuntu-workstation-install.log}"
readonly EXPECTED_CODENAME="${EXPECTED_CODENAME:-}"

ASSUME_YES=0
DRY_RUN=0
INSTALL_OPTIONAL=0
INSTALL_NOMACHINE=1

APT_CORE_PACKAGES=(
  apt-transport-https
  build-essential
  ca-certificates
  cmake
  curl
  default-jre
  dkms
  file
  git
  gnupg
  htop
  lsb-release
  make
  nano
  net-tools
  openssh-client
  openssh-server
  p7zip-full
  pkg-config
  python3-pip
  python3-venv
  software-properties-common
  tree
  unzip
  vim
  wget
  zip
)

APT_ENGINEERING_PACKAGES=(
  arduino
  blender
  freecad
  gimp
  inkscape
  kicad
  librecad
  meshlab
  rpi-imager
  vlc
)

APT_OPTIONAL_PACKAGES=(
  flameshot
  obs-studio
  remmina
  synaptic
  tilix
  timeshift
)

VS_CODE_EXTENSIONS=(
  ms-vscode.cpptools
  ms-vscode.cmake-tools
  ms-python.python
  redhat.vscode-xml
  twxs.cmake
)

log() {
  printf '[%s] %s\n' "$SCRIPT_NAME" "$*" | tee -a "$LOG_FILE" >&2
}

die() {
  log "ERROR: $*"
  exit 1
}

run() {
  log "+ $*"
  if [[ "$DRY_RUN" -eq 0 ]]; then
    "$@"
  fi
}

usage() {
  cat <<USAGE
Usage: $SCRIPT_NAME [options]

Options:
  -y, --yes            Run without confirmation prompts.
      --optional       Install optional desktop utilities.
      --no-nomachine   Skip NoMachine installation.
      --dry-run        Print commands without executing them.
  -h, --help           Show this help.

Environment variables:
  LOG_FILE             Log path. Default: $HOME/ubuntu-workstation-install.log
  EXPECTED_CODENAME    Optional expected Ubuntu codename, for example jammy or noble.
  NOMACHINE_AMD64_URL  Override NoMachine amd64 .deb URL.
  NOMACHINE_ARM64_URL  NoMachine arm64 .deb URL. Required for arm64 install.
USAGE
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -y|--yes)
        ASSUME_YES=1
        ;;
      --optional)
        INSTALL_OPTIONAL=1
        ;;
      --no-nomachine)
        INSTALL_NOMACHINE=0
        ;;
      --dry-run)
        DRY_RUN=1
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "Unknown option: $1"
        ;;
    esac
    shift
  done
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

require_ubuntu() {
  require_command dpkg
  require_command sudo

  if [[ ! -r /etc/os-release ]]; then
    die "Cannot read /etc/os-release."
  fi

  # shellcheck disable=SC1091
  source /etc/os-release

  if [[ "${ID:-}" != "ubuntu" ]]; then
    die "Unsupported OS: ${PRETTY_NAME:-unknown}. This installer targets Ubuntu."
  fi

  if [[ -n "$EXPECTED_CODENAME" && "${VERSION_CODENAME:-}" != "$EXPECTED_CODENAME" ]]; then
    log "WARNING: Expected Ubuntu codename '$EXPECTED_CODENAME', detected '${VERSION_CODENAME:-unknown}'."
    log "The script may still work, but package availability can differ."
  fi
}

detect_architecture() {
  dpkg --print-architecture
}

confirm() {
  [[ "$ASSUME_YES" -eq 1 ]] && return 0

  printf '\nThis will install workstation applications and may modify system repositories.\n'
  printf 'Log file: %s\n\n' "$LOG_FILE"
  read -r -p "Continue? [y/N] " answer
  [[ "$answer" =~ ^[Yy]$ ]] || die "Cancelled by user."
}

apt_update() {
  run sudo apt-get update
}

apt_install() {
  local packages=("$@")
  [[ "${#packages[@]}" -gt 0 ]] || return 0

  run sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y "${packages[@]}"
}

apt_package_available() {
  local package="$1"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    return 0
  fi

  apt-cache policy "$package" 2>/dev/null | awk '
    $1 == "Candidate:" && $2 != "(none)" {
      found = 1
    }
    END {
      exit found ? 0 : 1
    }
  '
}

apt_install_available() {
  local package
  local available_packages=()
  local skipped_packages=()

  for package in "$@"; do
    if apt_package_available "$package"; then
      available_packages+=("$package")
    else
      skipped_packages+=("$package")
    fi
  done

  if [[ "${#skipped_packages[@]}" -gt 0 ]]; then
    log "Skipping unavailable APT packages: ${skipped_packages[*]}"
  fi

  apt_install "${available_packages[@]}"
}

apt_install_available() {
  local package
  local available_packages=()
  local skipped_packages=()

  for package in "$@"; do
    if apt_package_available "$package"; then
      available_packages+=("$package")
    else
      skipped_packages+=("$package")
    fi
  done

  if [[ "${#skipped_packages[@]}" -gt 0 ]]; then
    log "Skipping unavailable APT packages: ${skipped_packages[*]}"
  fi

  apt_install "${available_packages[@]}"
}

install_core_packages() {
  log "Installing core development/system packages..."
  apt_install_available "${APT_CORE_PACKAGES[@]}"
}

install_engineering_apps() {
  log "Installing engineering and creative applications..."
  apt_install_available "${APT_ENGINEERING_PACKAGES[@]}"

  log "Adding current user to dialout group for Arduino serial access..."
  run sudo usermod -aG dialout "$USER"

  fi

  log "Installing optional desktop utilities..."
  apt_install_available "${APT_OPTIONAL_PACKAGES[@]}"
}

install_optional_apps() {
  if [[ "$INSTALL_OPTIONAL" -eq 0 ]]; then
    log "Skipping optional desktop utilities. Use --optional to install them."
    return 0
  fi

  log "Installing optional desktop utilities..."
  apt_install "${APT_OPTIONAL_PACKAGES[@]}"
}

install_vscode_repo() {
  local arch="$1"

  case "$arch" in
    amd64|arm64|armhf)
      ;;
    *)
      log "Skipping VS Code: unsupported architecture '$arch'."
      return 0
      ;;
  esac

  log "Installing Microsoft VS Code APT repository..."
  apt_install wget gpg apt-transport-https

  local keyring="/usr/share/keyrings/packages.microsoft.gpg"
  local repo_file="/etc/apt/sources.list.d/vscode.list"

  if [[ "$DRY_RUN" -eq 0 ]]; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
      | gpg --dearmor \
      | sudo tee "$keyring" >/dev/null
    sudo chmod 644 "$keyring"
    printf 'deb [arch=%s signed-by=%s] https://packages.microsoft.com/repos/code stable main\n' "$arch" "$keyring" \
      | sudo tee "$repo_file" >/dev/null
  else
    log "+ install Microsoft signing key to $keyring"
    log "+ create $repo_file"
  fi

  apt_update
  apt_install code
}

install_vscode_extensions() {
  command -v code >/dev/null 2>&1 || {
    log "Skipping VS Code extensions because 'code' command is unavailable."
    return 0
  }

  log "Installing recommended VS Code extensions..."
  local extension
  for extension in "${VS_CODE_EXTENSIONS[@]}"; do
    run code --install-extension "$extension" --force
  done
}

install_eclipse() {
  if ! command -v snap >/dev/null 2>&1; then
    log "Installing snapd for Eclipse..."
    apt_install snapd
  fi

  log "Installing Eclipse via Snap..."
  run sudo snap install --classic eclipse
}

install_nomachine() {
  [[ "$INSTALL_NOMACHINE" -eq 1 ]] || {
    log "Skipping NoMachine."
    return 0
  }

  local arch="$1"
  local url=""
  local deb_path="/tmp/nomachine-${arch}.deb"

  case "$arch" in
    amd64)
      url="${NOMACHINE_AMD64_URL:-https://www.nomachine.com/free/linux/64/deb}"
      ;;
    arm64)
      url="${NOMACHINE_ARM64_URL:-}"
      if [[ -z "$url" ]]; then
        log "Skipping NoMachine arm64: set NOMACHINE_ARM64_URL to the current official .deb URL."
        return 0
      fi
      ;;
    *)
      log "Skipping NoMachine: unsupported architecture '$arch'."
      return 0
      ;;
  esac

  log "Installing NoMachine for $arch..."
  run wget -O "$deb_path" "$url"
  run sudo apt-get install -y "$deb_path"
  run rm -f "$deb_path"

  if [[ -x /usr/NX/bin/nxserver ]]; then
    run sudo /usr/NX/bin/nxserver --status
  elif [[ -x /etc/NX/nxserver ]]; then
    run sudo /etc/NX/nxserver --status
  fi
}

print_summary() {
  cat <<SUMMARY

Installation complete.

Recommended next steps:
  1. Reboot or log out/in so Arduino dialout group membership takes effect.
  2. Open VS Code and confirm extensions installed successfully.
  3. Review the install log: $LOG_FILE

Installed groups:
  - Core development/system packages
  - Engineering and creative applications
  - VS Code plus common extensions
  - Eclipse
  - NoMachine, unless skipped or unsupported
  - Optional desktop utilities only when --optional is used

SUMMARY
}

main() {
  parse_args "$@"
  : > "$LOG_FILE"

  require_ubuntu
  confirm

  local arch
  # shellcheck disable=SC1091
  source /etc/os-release

  log "Detected OS: ${PRETTY_NAME:-Ubuntu}"
  log "Detected architecture: $arch"

  apt_update
  install_core_packages
  install_engineering_apps
  install_optional_apps
  install_vscode_repo "$arch"
  install_vscode_extensions
  install_eclipse
  install_nomachine "$arch"

  print_summary | tee -a "$LOG_FILE"
}

main "$@"
