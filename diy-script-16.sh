#!/bin/bash



# TTYD 免登录
 sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config



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
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-bypass   ss  baocuo
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-adbyby-plus
git_sparse_clone master https://github.com/kiddin9/openwrt-packages adbyby
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-wrtbwmon
git_sparse_clone master https://github.com/kiddin9/openwrt-packages wrtbwmon
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-onliner

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm




./scripts/feeds update -a
./scripts/feeds install -a
