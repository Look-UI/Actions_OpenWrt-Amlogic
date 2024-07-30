#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# Modify some code adaptation
#sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' feeds/luci/applications/luci-app-cpufreq/Makefile

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set DISTRIB_REVISION
sed -i "s/OpenWrt /Deng Build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# Modify default IP（FROM 192.168.1.1 CHANGE TO 10.10.10.1）
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

# Modify system hostname（FROM OpenWrt CHANGE TO OpenWrt-N1）
# sed -i 's/OpenWrt/OpenWrt-N1/g' package/base-files/files/bin/config_generate

## ------------------插件配置-------------------------------##

# 添加主题
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# 更改 Argon 主题背景
cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# 取消主题默认设置
find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

## adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome

# 修改插件名字
sed -i 's/"Argon 主题设置"/"主题设置"/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/"带宽监控"/"带宽"/g' `grep "带宽监控" -rl ./`
sed -i 's/"TTYD 终端"/"终端"/g' `grep "TTYD 终端" -rl ./`
sed -i 's/"Alist 文件列表"/"Alist"/g' `grep "Alist 文件列表" -rl ./`
sed -i 's/"Aria2 配置"/"Aria2"/g' `grep "Aria2 配置" -rl ./`

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template

# 修复部分插件自启动脚本丢失可执行权限问题
sed -i '/exit 0/i\chmod +x /etc/init.d/*' package/lean/default-settings/files/zzz-default-settings

# golang版本修复
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
