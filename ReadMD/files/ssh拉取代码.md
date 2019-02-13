# ssh拉取代码 dogs没有成功。。。。。

1. 新电脑创建ssh

> ```
> ssh-keygen -t rsa -b 4096 -C "hechuan@dogotsn.com"
> ```

2.使用系统默认的路径存储

> ```
> Enter a file in which to save the key (/Users/you/.ssh/id_rsa): [Press enter]
> ```

3.输入密码



4.添加到 ssh-agent

> ```
> eval "$(ssh-agent -s)"
> ```

5. 存储到keychain

   >```
   >ssh-add -K ~/.ssh/id_rsa
   >```

6.通过命令copy ssh

> ```
> pbcopy < ~/.ssh/id_rsa.pub
> ```

7.添加这些内容到网站



8.验证

> ssh -T git@118.31.39.243:zhangning/duojia4iOS.git

```
ssh -p 22 develop5@118.31.39.243
```

Url http://118.31.39.243:3000/zhangning/duojia4iOS.git

ssh git@118.31.39.243:zhangning/duojia4iOS.git







develop5	wu0905