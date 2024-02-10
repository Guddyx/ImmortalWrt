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

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 移除要替换的包
rm -rf feeds/luci/applications/luci-app-passwall

# 添加luci-app-mosdns
git clone https://github.com/sbwml/luci-app-mosdns.git mosdns
cp -rf mosdns/luci-app-mosdns feeds/luci/applications/luci-app-mosdns
rm -rf mosdns

#添加luci-app-passwall
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git passwall_packages
git clone https://github.com/xiaorouji/openwrt-passwall.git passwall
cp -rf passwall/luci-app-passwall feeds/luci/applications/luci-app-passwall
cp -rf passwall_packages/gn feeds/packages/net
cp -rf passwall_packages/ssocks feeds/packages/net
rm -rf passwall_packages
rm -rf passwall
