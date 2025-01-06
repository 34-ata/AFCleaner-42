#!/bin/bash
# Alias'ı ekle

# Your root
BASE_DIR="/home/$(whoami)"
THIS_FOLDER="$(pwd)"

mkdir -p $BASE_DIR"/AFC"

TARGET_DIR=$BASE_DIR"/AFC/AFCleaner.sh"
cp $THIS_FOLDER"/AFCleaner.sh" $BASE_DIR"/AFC/"

BASH_RC="$BASE_DIR""/.bashrc"
ZSH_RC="$BASE_DIR""/.zshrc"

# Alias'ı eklemek için fonksiyon
add_alias() {
  local alias_name="$1"
  local file="$2"
  if ! grep -q "alias $alias_name=" "$file"; then
	  echo "alias $alias_name='bash '$TARGET_DIR" >> "$file"
  else
    echo "Alias $alias_name already exists in $file"
  fi
}

# BASH ve ZSH için alias ekle
add_alias "afclean" "$BASH_RC"
add_alias "afclean" "$ZSH_RC"

# Kullanıcıya alias'ların etkinleştirilmesi için terminalin yeniden başlatılması gerektiğini hatırlat
echo -e "\nRestart your shell. And you can now use AFCleaner with '\033[1;34mafclean\033[0m' command"

