# Git命令行

1. 从仓库拉下来

`git clone ssh://git@221.122.67.198:2224/mobile/alltokent_ios.git`

使用了ssh,这个ssh需要在gitlab上配置一下,把本地计算机的弄上去



2. 添加文件

``````shell
git add <filename>
git add *
#添加所有文件
git  add .
``````

一般使用add . 添加所有的文件



3. 提交信息

`git commit -m "代码提交信息"`



4. 添加到分支或者主分支上

`git push -u origin master `



官方方法说明,使用起来参考比较直接

1.Git global setup

```shell
git config --global user.name "hechuan"
git config --global user.email "631075479@qq.com"
```

2.Create a new repository

```shell
git clone ssh://git@221.122.67.198:2224/mobile/alltokent_ios.git
cd alltokent_ios
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

3.Existing folder

```shell
cd existing_folder
git init
git remote add origin ssh://git@221.122.67.198:2224/mobile/alltokent_ios.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

4.Existing Git repository

```shell
cd existing_repo
git remote add origin ssh://git@221.122.67.198:2224/mobile/alltokent_ios.git
git push -u origin --all
git push -u origin --tags
```



