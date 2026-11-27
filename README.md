[![GitHub release (latest by date)](https://img.shields.io/github/v/release/shawnpxtl/Actions-CMCC-RAX3000M?style=for-the-badge&label=下载)](https://github.com/shawnpxtl/Actions-CMCC-RAX3000M/releases/latest)

# 关于这个仓库

> 这个仓库基于[P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)<br>

用Github Actions为中国移动RAX3000M自动编译固件  
本项目的固件原则上每周自动编译一次，您也可以fork自行修改~  
如果您觉得本项目不错的话，可以Star一下，我会感激不尽的！就酱~  

## 特性

Docker、WireGuard、OpenVPN、AdGuardHome、OpenClash、DDNS-GO、Lucky、iStore、Argon、UPnP

* 更多功能自行刷入查看(可能会不定期变动)...

## 后台进入方式和密码

   | 项目 | 值 |
   | :--- | :--- |
   | 默认后台地址 | `192.168.10.1` |
   | 默认后台密码 | `无密码` |

## 其它教程（大多数教程均来自互联网，此处作备份用） <a id="tutorial"></a>

* [如何更新固件](tutorial/ru-he-geng-xin-gu-jian.md)

## 截图

![luci\_admin\_status\_overview](.gitbook/assets/RAX3000M.jpg)

## 已知问题
#### 免责声明：以下部分已知问题为个人实测，可能还有未知问题，本人不对因固件导致的问题和事故承担任何责任

* ~~已知237源码集成的Mediatek HNAT加速，在WiFi连接下会导致App图片等资源加载异常，要一劳永逸的话直接关掉，非要同时使用并且想尽量缓解症状的话可以关闭ipv6且将HNAT连接速率绑定阈值调至1~~(chasey-dev源码无此问题)
* turboacc仅开启BBR算法可用，请勿打开其中的硬件加速选项，mtk硬件加速已经默认开启，与turboacc中的硬件加速以及防火墙中的路由/NAT卸载功能冲突，打开会无限重启。

## 所用源码

* [hanwckf](https://github.com/hanwckf/immortalwrt-mt798x)(immortalwrt 21.02,历史,2025.10-2025.12)
* [237](https://github.com/padavanonly/immortalwrt-mt798x-6.6)(immortalwrt 24.10,历史,2025.12-2026.7)
* [chasey-dev](https://github.com/chasey-dev/immortalwrt-mt798x-rebase)(immortalwrt 25.12,目前使用)

## 感谢

* [Microsoft Azure](https://azure.microsoft.com/)
* [GitHub Actions](https://github.com/features/actions)
* [OpenWRT](https://github.com/openwrt/openwrt)
* [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
* [tmate](https://github.com/tmate-io/tmate)
* [P3TERX](https://github.com/P3TERX)<br>
* 以及所有跟OpenWRT/ImmortalWrt等相关的贡献者
