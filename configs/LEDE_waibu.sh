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
 
 # 在线用户
git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-onliner

# 科学
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-bypass
git_sparse_clone master https://github.com/kiddin9/openwrt-packages redsocks2
git_sparse_clone master https://github.com/kiddin9/openwrt-packages lua-neturl
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-ssr-plus
git_sparse_clone master https://github.com/kiddin9/openwrt-packages shadow-tls
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-v2raya
git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2raya
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash


./scripts/feeds update -a
./scripts/feeds install -a

#   make menuconfig
