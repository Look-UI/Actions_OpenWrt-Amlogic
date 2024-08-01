# Actions-OpenWrt
所有盒子固件均采用同一底包，默认为打包N1盒子的固件，如需打包其他型号盒子参照flippy的打包脚本说明修改.yml流程文件即可。

-项目使用 Github Actions 拉取 Lean 的 Openwrt 源码仓库进行云编译
-固件默认管理地址：192.168.31.31 默认用户：root 默认密码：password
-集成 Docker 服务，可在 OpenWrt 内自由部署 Docker 应用
-集成无线网卡驱动,可通过wifi进行配置后台
-集成晶晨宝盒，支持在线更新固件及内核


## 感谢
- [Lean's OpenWrt 源码仓库](https://github.com/coolsnowwolf/lede)
- [immortalwrt's OpenWrt 源码仓库](https://github.com/immortalwrt/immortalwrt)
- [flippy 内核与打包脚本](https://github.com/unifreq/openwrt_packit)
- [ophub 内核打包参数说明](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/README.cn.md#%E4%BD%BF%E7%94%A8-github-actions-%E8%BF%9B%E8%A1%8C%E7%BC%96%E8%AF%91)
- [kenzok8 软件包收集仓库](https://github.com/kenzok8/small-package)
- [p3terx 云编译教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)
- 所有OpenWrt源码贡献者、插件开发者


## License

[MIT](https://github.com/P3TERX/Actions-OpenWrt/blob/main/LICENSE) © [**P3TERX**](https://p3terx.com)
