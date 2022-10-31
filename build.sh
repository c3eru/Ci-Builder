#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

git clone --depth=1 https://github.com/c3eru/dtchime -b lineage-19.1 device/xiaomi/chime
git clone --depth=1 https://github.com/frstprjkt/vendor_xiaomi_chime -b twelve vendor/xiaomi/chime
git clone --depth=1 https://github.com/greenforce-project/kernel_xiaomi_citrus_sm6115 -b rvc kernel/xiaomi/chime
git clone --depth=1 https://github.com/kdrag0n/proton-clang -b master prebuilts/clang/host/linux-x86/clang-proton

# build rom
source build/envsetup.sh
lunch lineage_chime-userdebug
export TZ=Asia/Jakarta
export KBUILD_BUILD_USER=mobx
export KBUILD_BUILD_HOST=builder-ci-task-kang-moment
export BUILD_USERNAME=mobx
export BUILD_HOSTNAME=builder-ci-task-kang-moment
make bacon -j8
# end 

# build 3
