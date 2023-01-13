#!/bin/bash

echo “Source Vars”
export USE_CCACHE=1
export CCACHE_SIZE=60G
export ALLOW_MISSING_DEPENDENCIES=true

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Change to the Source Directry
cd ~/android


# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 60G
else
    ccache -M ${CCACHE_SIZE}
fi

# Prepare the Build Environment
cd ~/android
cd ~/android/SDM845/android
source build/envsetup.sh
lunch sdm845-userdebug

# Build!
echo 'Start Build!'
make -j$(nproc --all)

# Exit
exit 0
