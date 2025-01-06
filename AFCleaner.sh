#!/bin/bash

# This cleaner is a version of CCleaner of abouykou

echo -e "\n"
echo -e "		░█████╗░███████╗░█████╗░██╗░░░░░███████╗░█████╗░███╗░░██╗███████╗██████╗░
		██╔══██╗██╔════╝██╔══██╗██║░░░░░██╔════╝██╔══██╗████╗░██║██╔════╝██╔══██╗
		███████║█████╗░░██║░░╚═╝██║░░░░░█████╗░░███████║██╔██╗██║█████╗░░██████╔╝
		██╔══██║██╔══╝░░██║░░██╗██║░░░░░██╔══╝░░██╔══██║██║╚████║██╔══╝░░██╔══██╗
		██║░░██║██║░░░░░╚█████╔╝███████╗███████╗██║░░██║██║░╚███║███████╗██║░░██║
		╚═╝░░╚═╝╚═╝░░░░░░╚════╝░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝"
echo -en "\n                       By: "
echo -e "\033[33m42 Istanbul\033[0m [𝓪𝓫𝓸𝓼𝓽𝓪𝓷𝓸 && 𝓯𝓪𝓪𝓽𝓪]\n"

# Your root
BASE_DIR="/home/$(whoami)"

# Available Space of PC
function print_disk_space {
  local message=$1
  local free_space=$(df -h "$BASE_DIR" | awk 'NR==2 {print $4}')
  echo "$message: $free_space"
}

# Clean Func
function clean_glob {
  if [ -z "$1" ]; then
    return 0
  fi
  /bin/rm -rf "$@" &>/dev/null
  return 0
}

function clean {
  # Prompt user for confirmation before proceeding with deletion
  read -p "Are you sure you want to clean cache and trash? (y/n) " confirm
  if [[ "$confirm" != [yY] ]]; then
    echo "Cleaning aborted."
    return
  fi

  sleep 2
  
  # Clean application caches with loading effect
  for dir in "$BASE_DIR/.var/app/com.visualstudio.code/cache/vscode-cpptools/*" \
             "$BASE_DIR/.var/app/com.visualstudio.code/cache/tmp" \
             "$BASE_DIR/.var/app/com.visualstudio.code/data/recently-used.xbel" \
             "$BASE_DIR/.var/app/com.google.Chrome/cache/*" \
             "$BASE_DIR/.var/app/com.brave.Browser/cache/*" \
             "$BASE_DIR/.var/app/org.mozilla.firefox/cache/*" \
             "$BASE_DIR/.var/app/com.opera.Opera/cache/*" \
             "$HOME/.local/share/Trash/*"; do
    for file in $dir; do
      clean_glob "$file"
      # Show loading effect
      for i in {1..3}; do
        echo -n "."
        sleep 0.2
      done
      echo -ne "\r                     \r" # Clear line
    done
  done

  # Clean specific file types in the cache directory
  find "$HOME/.cache/" -type f \( -name "*.log" -o -name "*.tmp" -o -name "*.cache" \) -exec bash -c 'clean_glob "$0"; for i in {1..3}; do echo -n "."; sleep 0.2; done; echo -ne "\r                     \r"' {} \;
}

# Print available disk space before cleaning
print_disk_space "Available disk space before cleaning"

# Call the clean function
clean

print_disk_space "Available disk space after cleaning"

echo -e "\n            report any issues to us in:"
echo -e "                  GitHub   ~> \033[4;1;34macbst0\033[0m"
echo -e "                  GitHub   ~> \033[4;1;34m34-ata\033[0m"
echo -e "                  42 Slack ~> \033[4;1;34mabostano\033[0m"
echo -e "                  42 Slack ~> \033[4;1;34mfaata\033[0m\n"

