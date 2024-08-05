# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# TTYD 免登录
 sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 稀疏克隆软件
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-adbyby-plus
git_sparse_clone master https://github.com/kiddin9/openwrt-packages adbyby
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-wrtbwmon
git_sparse_clone master https://github.com/kiddin9/openwrt-packages wrtbwmon
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-opkg
git_sparse_clone master https://github.com/kiddin9/openwrt-packages opkg
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-jellyfin
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-alist
git_sparse_clone master https://github.com/kiddin9/openwrt-packages alist
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-cpulimit
git_sparse_clone master https://github.com/kiddin9/openwrt-packages cpulimit
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-ddns-go
git_sparse_clone master https://github.com/kiddin9/openwrt-packages ddns-go
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-disks-info
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-netspeedtest
git_sparse_clone master https://github.com/kiddin9/openwrt-packages homebox
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-speedtest-web
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages speedtest-web
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-unblockneteasemusic

# git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-onliner
git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh

# 科学 passwall和易有云文件管理在feed里
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-bypass
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash
git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-v2raya
git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2raya
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2


git_sparse_clone openwrt-18.06 https://github.com/immortalwrt/luci applications/luci-app-eqos
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-shutdown
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata

git clone --depth=1 -b 18.06 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git_sparse_clone main https://github.com/haiibo/packages luci-theme-atmaterial luci-theme-opentomcat luci-theme-netgear

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by Haiibo/g" package/lean/default-settings/files/zzz-default-settings

./scripts/feeds update -a
./scripts/feeds install -a
