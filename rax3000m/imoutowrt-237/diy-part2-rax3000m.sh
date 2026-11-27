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

# Add backup file and 


# Modify default IP and password
sed -i 's/192.168.6.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改连接数
# sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
# 修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

# 删除自带老版本OpenClash
# rm -rf feeds/luci/applications/luci-app-openclash
# themes添加（svn co 命令意思：指定版本如https://github）
# git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
# git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
# git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 添加额外软件包
# git clone https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata
# git clone https://github.com/xiaoxiao29/luci-app-adguardhome.git package/luci-app-adguardhome
sudo apt install -y libfuse-dev
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
rm -rf feeds/luci/applications/luci-app-openclash
git clone https://github.com/vernesong/OpenClash.git --depth=1 feeds/luci/applications/luci-app-openclash

# 添加核心温度的显示
# sed -i 's|pcdata(boardinfo.system or "?")|luci.sys.exec("uname -m") or "?"|g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
# sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# Modify NTP Server
sed -i "s/0.openwrt.pool.ntp.org/ntp.aliyun.com/g" package/base-files/files/bin/config_generate
sed -i "s/1.openwrt.pool.ntp.org/cn.ntp.org.cn/g" package/base-files/files/bin/config_generate
sed -i "s/2.openwrt.pool.ntp.org/cn.pool.ntp.org/g" package/base-files/files/bin/config_generate
# Add Docker LuCI manager and library
rm -rf /tmp/luci-app-dockerman /tmp/luci-lib-docker

git clone --depth=1 https://github.com/lisaac/luci-app-dockerman.git /tmp/luci-app-dockerman
cp -a /tmp/luci-app-dockerman/applications/luci-app-dockerman package/

git clone --depth=1 https://github.com/lisaac/luci-lib-docker.git /tmp/luci-lib-docker
cp -a /tmp/luci-lib-docker/collections/luci-lib-docker package/
# Add AdGuardHome LuCI with DNS redirect support
rm -rf /tmp/luci-app-adguardhome

git clone --depth=1 https://github.com/MinimaxFlora/luci-app-adguardhome.git /tmp/luci-app-adguardhome

cp -a /tmp/luci-app-adguardhome/luci-app-adguardhome package/
# Add DDNS-GO and its LuCI interface
rm -rf package/ddns-go
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git -C package/ddns-go checkout 6cd886e2942e768762c2a1021ab470e277cb4fef
# Add Lucky and its LuCI interface
rm -rf package/lucky
git clone --depth=1 https://github.com/sirpdboy/luci-app-lucky.git package/lucky
# Add OpenAppFilter v6.1.7
rm -rf package/OpenAppFilter
git clone --depth=1 --branch v6.1.7 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# Set Docker data directory on eMMC
sed -i "s|option data_root '/opt/docker/'|option data_root '/mnt/mmcblk0p7/docker'|" feeds/packages/utils/dockerd/files/etc/config/dockerd
# Refuse to start Docker unless the eMMC data partition is mounted
sed -i "/^start_service() {/a\\
    grep -qs ' /mnt/mmcblk0p7 ' /proc/mounts || { logger -t dockerd-init 'eMMC data partition is not mounted; refusing to start Docker'; return 1; }
" feeds/packages/utils/dockerd/files/dockerd.init
