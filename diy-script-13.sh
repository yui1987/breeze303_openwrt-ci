#libwrt专用

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

# 稀疏克隆软件     目录为主目录下   packages
git_sparse_clone master https://github.com/coolsnowwolf/packages net/shadowsocks-libev
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-adbyby-plus
git_sparse_clone master https://github.com/kiddin9/openwrt-packages adbyby
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-wrtbwmon
git_sparse_clone master https://github.com/kiddin9/openwrt-packages wrtbwmon
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-jellyfin
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-disks-info
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-linkease
git_sparse_clone master https://github.com/kiddin9/openwrt-packages linkease
git_sparse_clone master https://github.com/kiddin9/openwrt-packages ffmpeg-remux
git_sparse_clone master https://github.com/kiddin9/openwrt-packages linkmount
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-store
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-lib-taskd
git_sparse_clone master https://github.com/kiddin9/openwrt-packages taskd
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-lib-xterm
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome

#git_sparse_clone master https://github.com/coolsnowwolf/packages net
# git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata
# git_sparse_clone openwrt-18.06 https://github.com/immortalwrt/luci applications/luci-app-eqos
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-netspeedtest
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages homebox
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-speedtest-web
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages speedtest-web
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-unblockneteasemusic
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-opkg
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages opkg
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-alist
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages alist
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-cpulimit
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages cpulimit
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-ddns-go
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages ddns-go

# 在线用户
git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-onliner

# 科学
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-bypass
#git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-v2raya
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2raya
# git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash
# passwall和易有云文件管理在feed里

# 主题
git clone --depth=1 -b 18.06 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git_sparse_clone main https://github.com/haiibo/packages luci-theme-atmaterial luci-theme-opentomcat luci-theme-netgear
# git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

./scripts/feeds update -a
./scripts/feeds install -a
