
## 终极加密货币服务器安装程序！🚀

## 这是公开测试版 - 所有功能尚未最终确定！

一站式加密货币服务器需求安装程序。

**终极加密货币服务器安装程序！** 自动化完成以下版本的繁琐任务：

<img align="right" src="./.assets/install.gif?raw=true" height="215">

* YiiMP
* NOMP
* MPOS
* CryptoNote-Nodejs
* 通用水龙头脚本

## 目录

- [安装](#-installation)
- [使用方法](#-usage)
- [YiiMP 单服务器安装](#-yiimp-single-server-install)
  - [命令](#-commands)
- [YiiMP 多服务器安装](#-yiimp-multi-server-install)
- [NOMP 安装](#-nomp-install)
- [MPOS 安装](#-mpos-install)
- [CryptoNote-Nodejs 安装](#-cryptonote-nodejs-install)
- [通用水龙头脚本](#-generic-faucet-script)
- [致谢](#-credits)
- [许可证](#-license)
- [支持](#-support)

## 💾 安装

安装要求：

需要一个全新的 Ubuntu 20.04 或更高版本的系统。

```
curl https://raw.githubusercontent.com/cryptopool-builders/Multi-Pool-Installer/master/bootstrap.sh | bash
```

更新：

当有新版本发布时，更新只需要运行与安装相同的命令。

```
curl https://raw.githubusercontent.com/cryptopool-builders/Multi-Pool-Installer/master/bootstrap.sh | bash
```

## ▶️ 使用方法

你可以在 root 用户或现有账户下运行安装程序。如果你已经在服务器上创建了用户账户，该账户必须已经是 sudo 组的成员。

如果你以 root 身份运行，安装程序会提示你创建一个新账户。

<p align="center">
  <img src="./.assets/naughty.png" alt="naughty"
       width="555" height="185">
</p>

创建新用户账户或更新现有账户后，你必须重启机器以正确更新账户权限。

重启服务器后，使用你的用户账户输入以下命令启动安装程序：
```
multipool
```

## ⚙️ YiiMP 单服务器安装

YiiMP 单服务器安装推荐用于私人或非常小型的矿池。建议至少有 4GB 内存才能正常运行。
回答以下问题后，安装过程将自动进行：

问题 | 默认值 | 帮助
:--|:-:|:--
是否使用域名 | 否 | 如果你计划使用类似 example.com 的域名，请确保 DNS 已更新
是否使用子域名作为主域名 | 否 | 如果你计划使用类似 pool.example.com 的域名
域名 | localhost | 更改为你的域名，如 example.com 或 pool.example.com
矿池域名 | stratum.domain.name | 这应该与你的域名不同
安装 SSL | 是 | 从 LetsEncrypt 安装 90 天的证书
支持邮箱 | root@localhost | 用于发送系统警报
你的公网 IP | 自动获取最后访问 Web 服务器的 IP | 可以到 http://www.whatsmyip.org 验证
数据库 Root 密码 | 自动生成 36 位密码 | 默认 mysql root 密码
数据库面板用户密码 | 自动生成 36 位密码 | 默认 mysql 前端密码
数据库矿池密码 | 自动生成 36 位密码 | 默认 mysql 矿池密码
管理门户访问位置 | AdminPortal | 访问方式 example.com/site/AdminPortal

安装大约需要 25 分钟才能完全完成。屏幕上会显示完成消息。

#### 安装完成后必须重启服务器以完成安装过程！

重启服务器并登录到你的用户账户后，你会看到以下界面：

<p align="center">
  <img src="./.assets/first_reboot.png" alt="first_reboot"
       width="771" height="635">
</p>

#### 首次重启后，cron 屏幕可能需要最多 10 分钟才能自动启动。等待十分钟后输入：
```
motd
```
你应该会看到这个：

<p align="center">
  <img src="./.assets/running.png" alt="running"
       width="740" height="655">
</p>

#### To help make your server more secure we have changed the install locations and directory structure of YiiMP as follows:

Directory | Files
:--|:-:
/home/crypto-data/yiimp | General install location for YiiMP
/home/crypto-data/yiimp/starts | screens and stratum sh files - you do not need to run these
/home/crypto-data/yiimp/site | -
/home/crypto-data/yiimp/site/web | New location for YiiMP web files
/home/crypto-data/yiimp/site/backup | backup location for mysql DB
/home/crypto-data/yiimp/site/configuration | New location of your serverconfig.php
/home/crypto-data/yiimp/site/crons | New location of the `main:blocks:loop2` sh files
/home/crypto-data/yiimp/site/log | New location for debug.log and your nginx server log
/home/crypto-data/yiimp/site/stratum | New location for your stratum files
/home/crypto-data/wallets | New location for wallets

Permissions have been setup correctly allowing your main user write acess to the /home/crypto-data directories! Changing file or directory permissions after install will cause your YiiMP to not function correctly, you have been warned!!

By default even though all stratum algos start on server start, the ports have been blocked by the firewall. To open a port type:
```
sudo ufw allow port number
```

From there your YiiMP Single Server installation is fully completed. You can now go to example.com/site/AdminPortal to access your admin section and start adding your coins.

#### 🔗 Commands

To view a screen type:
```
screen -r main|loop2|blocks|debug
```
To detach from a screen type:
```
ctrl+a+d
```
To start, stop or restart main|loop2|blocks|debug type:
```
screens start|stop|restart main|loop2|blocks|debug
```
We also suggest that you type:
```
yiimp
```
and get to know those commands as well!

## 🤖 YiiMP 多服务器安装

以下两个表格展示了多服务器设置的推荐配置：

角色 | 系统版本 | 推荐内存
:--|:--|:-:
Web 服务器 | Ubuntu 20.04 或更高版本 | 2GB
数据库和矿池服务器 | Ubuntu 20.04 或更高版本 | 4GB
钱包服务器 | Ubuntu 20.04 或更高版本 | 8GB+

或者

角色 | 系统版本 | 推荐内存
:--|:--|:-:
Web 服务器 | Ubuntu 20.04 或更高版本 | 2GB
数据库服务器 | Ubuntu 20.04 或更高版本 | 2GB
矿池服务器 | Ubuntu 20.04 或更高版本 | 2GB
钱包服务器 | Ubuntu 20.04 或更高版本 | 8GB+

强烈建议使用提供服务器之间私有 IP 的服务商。如果你的服务商只提供公网 IP，你必须安装 Wireguard（安装程序已提供）。这将为你的服务器之间的后端通信建立安全的 VPN 连接。

#### 如果安装 Wireguard，请不要修改提供的默认私有 IP，否则安装将失败！

Just like with the single server install there must be a user account created. If you attempt to run the script under root, it will force you to create a new user account and log in to it.

After the user accounts are created on each server, setup <b>MUST</b> begin on the server that is hosting your database. You do not need to run the installer individually on each server.  

#### ✏️ During the setup process you will be prompted to enter the user name and password for each of your servers. This is required for the installer to be able to SSH in to each server to perform the installation tasks on that server.

Installation will take about 25 minutes to fully complete. You will get a message on the screen letting you know it has finished.

#### A server reboot is REQUIRED after the installer is completed to finalize the installation process!

#### On first reboot it may take up to 1 minute before the cron screens auto-start. After waiting one minute type:
```
motd
```

#### To help make your server more secure we have changed the install locations and directory structure of YiiMP as follows:

Directory | Files | Server
:--|:-:|:--
/home/crypto-data/yiimp | General install location for YiiMP | All
/home/crypto-data/yiimp/starts | screens and stratum sh files - you do not need to run these | Web and Stratum
/home/crypto-data/yiimp/site | - | Web and Stratum
/home/crypto-data/yiimp/site/web | New location for YiiMP web files | Web
/home/crypto-data/yiimp/site/backup | backup location for mysql DB | Web
/home/crypto-data/yiimp/site/configuration | New location of your serverconfig.php | Web
/home/crypto-data/yiimp/site/crons | New location of the `main:blocks:loop2` sh files | Web
/home/crypto-data/yiimp/site/log | New location for debug.log and your nginx server log | Web
/home/crypto-data/yiimp/site/stratum | New location for your stratum files | Stratum
/home/crypto-data/wallets | New location for wallets | Daemon


Permissions have been setup correctly allowing your main user write acess to the /home/crypto-data directories! Changing file or directory permissions after install will cause your YiiMP to not function correctly, you have been warned!!

By default even though all stratum algos start on server start, the ports have been blocked by the firewall. To open a port type:
```
sudo ufw allow port number
```
You <b>MUST</b> also open the RPC Port number on the daemon server when adding new coins. Failing to open the port will result in a connection time out error.

From there your YiiMP Multi Server installation is fully completed. You can now go to example.com/site/AdminPortal to access your admin section and start adding your coins.

#### 🔗 Commands

To view a screen type:
```
screen -r main|loop2|blocks|debug
```
To detach from a screen type:
```
ctrl+a+d
```
To start, stop or restart main|loop2|blocks|debug type:
```
screens start|stop|restart main|loop2|blocks|debug
```
We also suggest that you type:
```
yiimp
```
and get to know those commands as well!



## 📦 NOMP Install

The NOMP options install everything you need to run NOMP and gets your first coin installed. It is recommended to have at least 2GB ram in order to function properly.

During the initial setup you will be asked similar questions as the YiiMP installer in addition you will also be asked for the first coin that you wish to have installed. After all the questions are answered setup will be fully automated until the coin installation where you will need to copy and paste the coind and coin-cli names.

#### To help make your server more secure we have changed the install locations and directory structure of NOMP as follows:

Directory | Files
:--|:-:
/home/crypto-data/nomp | General install location for NOMP
/home/crypto-data/nomp/starts | required start files
/home/crypto-data/nomp/core | New location for NOMP nodejs files
/home/crypto-data/nomp/configuration | New location for NOMP config files
/home/crypto-data/nomp/logs | New location for NOMP/Nginx log files
/home/crypto-data/nomp/site/web | New Location of NOMP html files
/home/crypto-data/wallets | New location for wallets

Permissions have been setup correctly allowing your main user write acess to the /home/crypto-data directories! Changing file or directory permissions after install will cause your NOMP to not function correctly, you have been warned!!

By default all non web ports have been blocked by the firewall, with exception of the first default coin. To open any other ports type:
```
sudo ufw allow port number
```

## 🐣 MPOS Install

This feature will be added at a later date.

The MPOS options install everything you need to run MPOS and gets your first coin installed. It is recommended to have at least 4GB ram in order to function properly.

During the initial setup you will be asked similar questions as the YiiMP installer in addition you will also be asked for the first coin that you wish to have installed. After all the questions are answered setup will be fully automated.  

## 🐛 CryptoNote-Nodejs Install

This feature will be added at a later date.

The CryptoNote-Nodejs options install everything you need to run CryptoNote-Nodejs and gets your first coin installed. It is recommended to have at least 4GB ram in order to function properly.

During the initial setup you will be asked similar questions as the YiiMP installer in addition you will also be asked for the first coin that you wish to have installed. After all the questions are answered setup will be fully automated.

## 📚 Generic faucet script

This feature will be added at a later date.

The faucet options install everything you need to run your own faucet script and setup multiple coins on it. Each coin will have their own sub-site.
Setup is automated after the following questions are answered:

## ❤️ Credits

The following GitHubs have been a source of inspiration and code:

* [mailinabox](https://github.com/mail-in-a-box/mailinabox)
* [realeas-it](https://github.com/webpro/release-it)

The following forks have been used in the making of the script:

* [YiiMP](https://github.com/tpruvot/yiimp)
* [NiceNOMP](https://github.com/cryptosharks131/NiceNOMP)
* [UNOMP](https://github.com/UNOMP/unified-node-open-mining-portal)
* [cryptonote-nodejs](https://github.com/dvandal/cryptonote-nodejs-pool)
* [faucet script](https://github.com/ChristianGrieger/Cryptocurrency-faucet-script)

## 🎓 License

[MIT](http://webpro.mit-license.org/)

## 🎁 Support

Join our active discord channel:

https://discord.gg/UGbGvna

Find our BitCoinTalk Thread at:

https://bitcointalk.org/index.php?topic=4980079.0

Donations for continued support of this script are welcomed at:

* BTC 3LegHBKdAmcdN9usBae5UPVnQWk5vCrUDy
* BCH 1C5b876B7ZJo6P1hjqKGBmorYoY8RuAm7D
* ETH 0x7BAEaae15De37A93e5Bcf27622F2E65ede90A35C
* ETC 0xc5C3E017087adB10C2FE085cF8eA9b1c9867Ff28
* LTC MAutGukgacY74Pv38k4DGs91RGTDbmUSmQ
