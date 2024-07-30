#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 免登录
 sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

han

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# 添加额外插件
 git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
 git clone --depth=1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/luci-app-serverchan
 git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/luci-app-ikoolproxy
 git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
 git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
 git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata
 git_sparse_clone openwrt-18.06 https://github.com/immortalwrt/luci applications/luci-app-eqos
 git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash
 git_sparse_clone master https://github.com/kiddin9/openwrt-packages linkease
 git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-linkease
 # git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-shutdown
 
# 科学上网插件
 git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
 git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
 git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
 git_sparse_clone master https://github.com/kiddin10/openwrt-packages luci-app-bypass

# Themes
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
