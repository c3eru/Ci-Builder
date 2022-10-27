#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/c3eru.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/c3eru/local_manifest --depth 1 -b c3eru-patch-1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

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

# build 4
