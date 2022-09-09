#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${APM_TMP_DIR}" ]]; then
    echo "APM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${APM_PKG_INSTALL_DIR}" ]]; then
    echo "APM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${APM_PKG_BIN_DIR}" ]]; then
    echo "APM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/AttifyOS/mqtt-pwn/releases/download/v40368e5/mqtt-pwn-x86_64.AppImage -O $APM_TMP_DIR/mqtt-pwn-x86_64.AppImage
  mv $APM_TMP_DIR/mqtt-pwn-x86_64.AppImage $APM_PKG_INSTALL_DIR/mqtt-pwn-x86_64.AppImage
  chmod +x $APM_PKG_INSTALL_DIR/mqtt-pwn-x86_64.AppImage
  ln -s $APM_PKG_INSTALL_DIR/mqtt-pwn-x86_64.AppImage $APM_PKG_BIN_DIR/mqtt-pwn
}

uninstall() {
  rm $APM_PKG_INSTALL_DIR/mqtt-pwn-x86_64.AppImage
  rm $APM_PKG_BIN_DIR/mqtt-pwn
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1