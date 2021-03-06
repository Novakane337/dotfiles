#!/usr/bin/env bash

# Scripts for basic Arch maintenance
# Novacane337

echo "Beginning of the maintenance..."

# Some separation for the recap file
separator () {
  echo " "
  echo "$1"
  echo " "
}

# Print system information
infos_system () {
    echo "Starting system infos"
    separator 'INFO SYSTEM'
    whoami
    hostname
    date
    uname -a
  
    yay -Ps
    echo "End"
}

# Check if any systemd services have entered in a failed state
failed_services () {
    echo "Checking failed systemd services"
    separator "FAILED SERVICES"
    systemctl --failed
    echo "End"
}

# Look for errors in the log files located at /var/log,
# as well as high priority errors in the systemd journal
log_files () {
    echo "Look for errors in the log files located at /var/log,"
    separator "LOGFILES"
    journalctl -p 3 -xb
    echo "End"
}

# Check if ther .pac files
pac_files () {
    echo "Locating .pac* files"
    separator "PACNEW/SAVE"
    find / -regextype posix-extended -regex ".+\.pac(new|save)" 2> /dev/null
    echo "End"
}

# Check if there is broken symlinks
broken_links () {
    echo "List all the broken symlinks of your system"
    separator "BROKEN LINKS"
    find . -xtype l
    echo "End"
}


# Check if there is packages to update
check_updates () {
    echo "Checking for update"
    separator "UPDATES"
    if [[ -z $(checkupdates) ]]; then
        echo "All packages are up to date"
    else
        checkupdates
    fi
    echo "End"
}

# Check orpahans packages
check_orphans () {
    echo "Checking for orphans and dropped packages"
    separator "ORPHANS"
    if [[ -z $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        pacman -Qdt
    fi
    echo "End"
}

# Clean pacman cache
clear_cache () {
    echo "Removing unwanted .pkg files from /var/cache/pacman/pkg/ "
    separator "CACHE"
    echo "Need superuser privilege..."
    echo "Do you want to delete cache ?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo paccache -rk3; break;;
            No ) exit;;
        esac
    done
    echo "End"
}

# List of installed packages
list_pkg () {
    echo "To install packages from the list backup, run:"
    echo "pacman -S - < pkg.txt"
    echo "To skip already installed packages, use --needed"

    date

    separator 'PKG LIST'
    pacman -Qqe | grep -vx "$(pacman -Qqm)"
}

# List of installed packages from aur
list_aur () {

    date

    separator 'AUR LIST'
    pacman -Qqme
}

maintenance_file () {
    # Make a directory to save files
    now=$(date +"%d_%m_%Y")
    mkdir -p "$HOME"/docs/arch_bkup/"$now"

    # Save all results
    arch_maintenance > $HOME/usr/doc/archBackup/$now/arch-maint.txt
    pkg_list > $HOME/usr/doc/archBackup/$now/pkg.txt
    aur_list > $HOME/usr/doc/archBackup/$now/pkg_aur.txt
}

echo "End of maintenance"
notify-send 'End of maintenance.' 'Have a good day.'
