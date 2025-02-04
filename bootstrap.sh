#!/usr/bin/env bash

#########################################################
# 来源: https://mailinabox.email/ https://github.com/mail-in-a-box/mailinabox
# 由 cryptopool.builders 更新用于加密货币挖矿...
# 此脚本的预期运行方式:
#
#   curl https://raw.githubusercontent.com/cryptopool-builders/Multi-Pool-Installer/master/bootstrap.sh | bash
#
#########################################################

# 检查是否为 Ubuntu 20.04 或更高版本
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$ID" != "ubuntu" ]; then
        echo "错误: 此脚本仅支持 Ubuntu 系统"
        echo "当前系统: $PRETTY_NAME"
        exit 1
    fi
    
    # 将版本号转换为数字进行比较
    version=$(echo "$VERSION_ID" | awk -F. '{ print $1 $2 }')
    if [ "$version" -lt 2004 ]; then
        echo "错误: 此脚本仅支持 Ubuntu 20.04 及以上版本"
        echo "当前系统版本: $PRETTY_NAME"
        exit 1
    fi
fi

# 如果没有设置 TAG 环境变量，则使用默认版本
if [ -z "${TAG}" ]; then
	TAG=v2.55
fi

# 检查并克隆 MultiPool 仓库（如果不存在）
if [ ! -d $HOME/multipool ]; then
	# 检查是否安装了 git，如果没有则安装
	if [ ! -f /usr/bin/git ]; then
		echo Installing git . . .
		# 更新软件包列表
		apt-get -q -q update
		# 静默安装 git，不需要用户交互
		DEBIAN_FRONTEND=noninteractive apt-get -q -q install -y git < /dev/null
		echo
	fi

	echo Downloading MultiPool Installer ${TAG}. . .
	# 克隆指定版本的仓库，使用 --depth 1 只获取最新版本以节省空间
	git clone \
		-b ${TAG} --depth 1 \
		https://github.com/cryptopool-builders/multipool_setup \
		"$HOME"/multipool/install \
		< /dev/null 2> /dev/null

	echo
fi

# 设置权限并切换到安装目录
cd $HOME/multipool/install

# 更新仓库
# 确保 git 目录的所有权属于当前用户
sudo chown -R $USER $HOME/multipool/install/.git/
# 检查当前版本是否需要更新
if [ "${TAG}" != `git describe --tags` ]; then
	echo Updating MultiPool Installer to ${TAG} . . .
	# 强制获取指定标签的更新
	git fetch --depth 1 --force --prune origin tag ${TAG}
	# 切换到指定版本
	if ! git checkout -q ${TAG}; then
		echo "Update failed. Did you modify something in `pwd`?"
		exit
	fi
	echo
fi

# 启动安装脚本
bash $HOME/multipool/install/start.sh
