#!/bin/bash

mkdir ~/bin
PATH=~/bin:$PATH

cd ~
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# FUCK H
rm -rf ~/android
mkdir ~/android
cd ~/android

telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

cd ~/android
repo init -u https://github.com/OnePlusOSS/android.git -b oneplus6/9.0.0
repo sync -j$(nproc --all) --force-sync

exit 0
