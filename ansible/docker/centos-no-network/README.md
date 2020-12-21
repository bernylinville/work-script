# centos-no-network

政务网无外网，导入 yum 包本地安装

```shell
# 先下载 yum 包
yum install --downloadonly --downloaddir=ansible ansible

# 在政务云机器安装
rpm -Uvh --force --nodeps ansible/*.rpm
```