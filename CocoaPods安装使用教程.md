#### CocoaPods安装教程
Mac电脑自带Ruby环境，所以我们只需要直接打开终端，看下Ruby的版本是多少。现在安装cocoapods要求ruby版本>=2.2.2
所以如果我们发现Mac的Ruby版本号过低的话，就需要我们手动升级。

##### 查看当前Ruby版本号
```
 ruby -v
```
##### 升级Ruby版本
升级Ruby版本需要先安装rvm
```
curl -L get.rvm.io | bash -s stable 

source ~/.bashrc

source ~/.bash_profile
```
##### 执行完上述命令后，我们就可以查看可以安装的Ruby版本了
```
rvm list known
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190312223720169.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjc3OTk5Nw==,size_16,color_FFFFFF,t_70)
可以看到最新的版本是2.6.0
##### 安装一个Ruby版本
```
rvm install 2.6.0
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019031321354932.png)
##### 查看源，更换源
因为有一堵墙，所以国外的源，会出现连接不了或太慢。所以更换成国内的源

先查看下我们的源
```
gem sources -l
```
会展示出我们现在的源
如果显示的源是
```
https://rubygems.org/
```
那么我们将它替换为国内的源
```
sudo gem update --system

gem sources --remove https://rubygems.org/

gem sources --add https://gems.ruby-china.com/
```
再次查看源，如果是下面样子说明我们替换成功
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190313212414224.png)
##### 安装CocoaPods
在终端输入下列命令
```
sudo gem install -n /usr/local/bin cocoapods
```
会看到终端输出下列
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190313213826862.png)
然后输入
```
pod setup
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190313214209425.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjc3OTk5Nw==,size_16,color_FFFFFF,t_70)
如果看到上面的结果，恭喜安装成功了。
测试一下是否能够正常使用
```
pod search AFNetworking
```
经过漫长等待终于看到
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190313214827317.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjc3OTk5Nw==,size_16,color_FFFFFF,t_70)
好了可以正常使用CocoaPods了
