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
#sudo apt install gcc-11 g++-11

# 设置默认版本
#sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100
#sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100

# 配置默认版本
#sudo update-alternatives --config gcc
#sudo update-alternatives --config g++

# 验证安装
#gcc --version
#g++ --version

# 安装Clang
#sudo apt install -y clang

# 更新Go版本
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# 更新为LEDE-rust包
rm -rf feeds/packages/lang/rust
git clone https://github.com/coolsnowwolf/packages LEDE-packages
cp -rf LEDE-packages/lang/rust feeds/packages/lang/rust
 
# 移除要替换的包
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/dns2socks
rm -rf feeds/packages/net/geoview
rm -rf feeds/packages/net/hysteria
rm -rf feeds/packages/net/ipt2socks
rm -rf feeds/packages/net/microsocks
rm -rf feeds/packages/net/naiveproxy
rm -rf feeds/packages/net/shadow-tls
rm -rf feeds/packages/net/shadowsocks-libev
rm -rf feeds/packages/net/shadowsocks-rust
rm -rf feeds/packages/net/shadowsocksr-libev
rm -rf feeds/packages/net/simple-obfs
rm -rf feeds/packages/net/sing-box
rm -rf feeds/packages/net/tcping
rm -rf feeds/packages/net/trojan-plus
rm -rf feeds/packages/net/tuic-client
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/v2ray-plugin
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/xray-plugin


# 添加luci-app-passwall
git clone https://github.com/Openwrt-Passwall/openwrt-passwall.git passwall
cp -rf passwall/luci-app-passwall feeds/luci/applications/luci-app-passwall
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git passwall_packages
cp -rf passwall_packages/chinadns-ng feeds/packages/net/chinadns-ng
cp -rf passwall_packages/dns2socks feeds/packages/net/dns2socks
cp -rf passwall_packages/geoview feeds/packages/net/geoview
cp -rf passwall_packages/hysteria feeds/packages/net/hysteria
cp -rf passwall_packages/ipt2socks feeds/packages/net/ipt2socks
cp -rf passwall_packages/microsocks feeds/packages/net/microsocks
cp -rf passwall_packages/naiveproxy feeds/packages/net/naiveproxy
cp -rf passwall_packages/shadow-tls feeds/packages/net/shadow-tls
cp -rf passwall_packages/shadowsocks-libev feeds/packages/net/shadowsocks-libev
cp -rf passwall_packages/shadowsocks-rust feeds/packages/net/shadowsocks-rust
cp -rf passwall_packages/shadowsocksr-libev feeds/packages/net/shadowsocksr-libev
cp -rf passwall_packages/simple-obfs feeds/packages/net/simple-obfs
cp -rf passwall_packages/sing-box feeds/packages/net/sing-box
cp -rf passwall_packages/tcping feeds/packages/net/tcping
cp -rf passwall_packages/trojan-plus feeds/packages/net/trojan-plus
cp -rf passwall_packages/tuic-client feeds/packages/net/tuic-client
cp -rf passwall_packages/v2ray-core feeds/packages/net/v2ray-core
cp -rf passwall_packages/v2ray-geodata feeds/packages/net/v2ray-geodata
cp -rf passwall_packages/xray-core feeds/packages/net/xray-core
cp -rf passwall_packages/xray-plugin feeds/packages/net/xray-plugin
#rm -rf passwall_packages
#rm -rf passwall

echo 'refresh feeds'
./scripts/feeds update -a
./scripts/feeds install -a

