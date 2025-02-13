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

# 添加PPA源
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update

# 安装最新的GCC（假设为GCC 11）
sudo apt install gcc-11 g++-11

# 设置默认版本
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100

# 配置默认版本
sudo update-alternatives --config gcc
sudo update-alternatives --config g++

# 验证安装
gcc --version
g++ --version

# 安装Go
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# 安装Clang
sudo apt install -y clang

# 移除要替换的包
#rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/geoview
rm -rf feeds/packages/net/shadowsocks-rust

# 添加luci-app-passwall
#git clone https://github.com/xiaorouji/openwrt-passwall.git passwall
cp -rf passwall/luci-app-passwall feeds/luci/applications/luci-app-passwall
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git passwall_packages
cp -rf passwall_packages/gn package/feeds/packages/gn
cp -rf passwall_packages/chinadns-ng feeds/packages/net/chinadns-ng
cp -rf passwall_packages/ssocks feeds/packages/net/ssocks
cp -rf passwall_packages/geoview feeds/packages/net/geoview
cp -rf passwall_packages/pdnsd-alt feeds/packages/net/pdnsd-alt
cp -rf passwall_packages/shadowsocks-rust feeds/packages/net/shadowsocks-rust
cp -rf passwall_packages/shadowsocks-libev feeds/packages/net/shadowsocks-libev
cp -rf passwall_packages/shadowsocksr-libev feeds/packages/net/shadowsocksr-libev
cp -rf passwall_packages/trojan-plus feeds/packages/net/trojan-plus
#rm -rf passwall_packages
#rm -rf passwall

echo 'refresh feeds'
./scripts/feeds update -a
./scripts/feeds install -a

