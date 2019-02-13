

# 搭建WordPress 使用阿里oss作为媒体存储

参考使用oss链接

http://www.laozuo.org/12606.html



首先我有1个服务器，一直再用的是ssh，后来开始使用wp，再后来使用反向穿透

由于反向穿透配置能力问题，导致和早期的wp产生冲突，所以原来的wp基本挂掉。



所以计划使用2个服务器，再买一个，专门的Nginx服务器，里面需要有数据库，旧的隔离开；设计模式的装饰模式，如果重新弄回影响旧的功能，或者弄不清楚有哪些需要卸载，导致各种未知的问题。

## 第一种方式：经典手动配置

新服务器，使用的是debain 8.0

升级apt-get

> apt-get update

安装sudo

> apt-get install sudo

**增加交换区swap**

> dd if=/dev/zero of=/swapfile bs=1M count=400
>
> mkswap /swapfile
>
> swapon /swapfile
>
> 如果修改这个文件首先 先做 ：sudo swapoff -a  停掉 swapfile 然后执行上面1，2，3

安装nginx

> sudo apt-get install nginx

nginx 常用操作

> ```
> service nginx stop
> service nginx start
> service nginx restart
> update-rc.d nginx defaults 加入开机启动   shutdown -r now 测试是否可行
> 默认服务器根路径 /var/www/html
> 配置路径 /etc/nginx/nginx.conf
> ```

```
nginx 配置里是这样的
include /etc/nginx/conf.d/*.conf;
include /etc/nginx/sites-enabled/*;
```

安装vim

> apt-get install vim

安装db

> apt-get install mysql-server   
>
> > root 密码 XiaoShan.1129
>
> mysql 路径是 /etc/mysql
>
> vim my.cnf  从mysql目录进入修改mycnf文件  bind-address = 0.0.0.0 原来是127.0.0.1
>  /etc/init.d/mysql stop
>  /etc/init.d/mysql start

允许远程机器访问数据库

>mysql -u root -p
>
>GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'root_password' WITH GRANT OPTION;

安装wp

> 进入/var/www/html 默认nginx目录
>
> wget https://wordpress.org/latest.tar.gz
>
> 解压缩：gzip -d latest.tar.gz
>
> 再解压一次：tar xvf latest.tar
>
> ```
> cp -R wordpress/* /home/wwwroot/bjxagjjc.com
> ```
>
> 进入此文件夹，然后增加权限
>
> ```
> 	chmod -R 777 wp-admin/
>     chmod -R 777 wp-content/
>     chmod -R 777 wp-includes/
>     chmod -R 777 wp-config-sample.php
>     chmod -R 777 readme.html
> 
> ```



配置数据库吧！开始想超进到安装phpMyAdmin 但是发现会带来一些其他的无穷的问题

由于内部web服务器已经乱了，目前能力还不能解决这么复杂的问题，所以想用phpmyadmin，或者自己配置数据库。既然都重新安装系统了，所有我选择了安装LAMP

## 第二种方式：直接安装LAMP

1. 交换区是肯定需要弄大的，详情参考第一种方式里面调节交换区

*技巧，多次访问ssh会出问题*

> 这时候需要去/Users/edz/.ssh/known_hosts 文件吧对应 ip删除掉

2. 安装基本编译环境

> apt-get install build-essential 

3. 安装mysql

> apt-get install mysql-server

第三种方式：

换操作系统

参考链接：https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-centos-7#step-one-%E2%80%94-install-apache

Apache  配置文件

```
/etc/apache2/httpd.conf
```

##第四种：centos 7  nnd 折腾了这么多次还是centos好用。。。

/usr/local/mysql/data 数据库路径

Apache 密码root

Apache: httpd-2.4.35
Apache Location: /usr/local/apache

MariaDB: mariadb-10.3.10
MariaDB Location: /usr/local/mariadb
MariaDB Data Location: /usr/local/mariadb/data
MariaDB Root Password: root

PHP: php-7.2.11
PHP Location: /usr/local/php

phpMyAdmin: phpMyAdmin-4.8.3-all-languages
phpMyAdmin Location: /data/www/default/phpmyadmin

KodExplorer: kodfile-4.35
KodExplorer Location: /data/www/default/kod

安装方法：https://lamp.sh/install.html

安装包：https://lamp.sh/download.html

常见问题：https://lamp.sh/faq.html

安装失败了2次，最后一次成功了，要领就是不要选择最新或者最老的版本，或者默认的版本

----

其他：

安装python

> apt-get install python

安装 aptitude 类似yum 等包管理工具

> apt-get install aptitude

---

## 错误导致原因 中途安装了phpmyadmin 

到这里就出现了问题安装这个东西时候默认就装了阿帕奇，然后。。。。

安装phpMyAdmin

> ```
> 1. apt install phpmyadmin
> ```

这里有个东西没有安装上然后 修改 

>  /etc/apt/sources.list
>
> 添加源 
>
> ```
> deb http://archive.ubuntu.com/ubuntu bionic main universe
> deb http://archive.ubuntu.com/ubuntu bionic-security main universe
> deb http://archive.ubuntu.com/ubuntu bionic-updates main universe
> ```

然后对其进行update

> sudo apt update

再安装

> 1. apt-get install php-mbstring
> 2. apt install php-gettext

phpMyAdmin Apache配置文件添加到`/etc/apache2/conf-enabled/`目录中

> root@debian:/etc/apache2/conf-enabled# sudo phpenmod mbstring
> root@debian:/etc/apache2/conf-enabled# sudo systemctl restart apache2



----

参考链接

【1】https://www.howtoing.com/how-to-install-nginx-on-debian-8

【2】https://www.cnblogs.com/eoiioe/archive/2008/09/20/1294681.html

【3】https://askubuntu.com/questions/1064634/unable-to-install-php-mbstring

【4】https://www.howtoing.com/how-to-install-and-secure-phpmyadmin-on-debian-9

