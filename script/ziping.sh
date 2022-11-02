#!/usr/bin/env bash

msg() {
    echo -e "\e[1;32m$*\e[0m"
}

telegram_message() {
    curl -s -X POST "https://api.telegram.org/$TG_TOKEN/sendMessage" \
    -d chat_id="$TG_CHAT_ID" \
    -d parse_mode="HTML" \
    -d text="$1"
}

function enviroment() {
device=$(grep unch $CIRRUS_WORKING_DIR/build.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
name_rom=$(grep init $CIRRUS_WORKING_DIR/build.sh -m 1 | cut -d / -f 4)
file_name=$(cd $WORKDIR/rom/$name_rom/out/target/product/$device && ls *.zip)
branch_name=$(grep init $CIRRUS_WORKING_DIR/build.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
rel_date=$(date "+%Y%m%d")
DATE_L=$(date +%d\ %B\ %Y)
DATE_S=$(date +"%T")
}

function upload_rom() {
echo ━━━━━━━━━ஜ۩۞۩ஜ━━━━━━━━
msg Upload...
echo ━━━━━━━━━ஜ۩۞۩ஜ━━━━━━━━
cd $WORKDIR/rom/$name_rom
file_name=$(basename out/target/product/$device/*.zip)
DL_LINK=https://file.cloudmobx.workers.dev/Apps/Derp-13/Settings.apk
rclone copy out/target/product/$device/system_ext/priv-app/Settings/*.apk mobx:Apps/Derp-13 -P
curl -s https://api.telegram.org/$TG_TOKEN/sendDocument -d chat_id=$TG_CHAT_ID -d document=@out/target/product/$device/system_ext/priv-app/Settings/*.apk

echo
echo ━━━━━━━━━ஜ۩۞۩ஜ━━━━━━━━
msg Upload rom succes..
echo ━━━━━━━━━ஜ۩۞۩ஜ━━━━━━━━
echo
echo Download Link: ${DL_LINK}
echo
echo
}

msg
telegram_message
enviroment
upload_rom
