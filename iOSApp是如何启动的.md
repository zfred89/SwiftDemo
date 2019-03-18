转载自：https://blog.csdn.net/Hello_Hwc/article/details/78317863

#### Mach-o
哪些名词指的是Mach-o
Executable 可执行文件
Dylib动态库
Bundle无法被链接的动态库，只能通过dlopen加载
Image指的是Executable，Dylib和Bundle中的一种，会多次说到
Framework 动态库和对应头文件和资源的集合

苹果出品的操作系统的可执行文件基本上都是Mach-o文件，iOS也不例外

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190318095857941.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjc3OTk5Nw==,size_16,color_FFFFFF,t_70)
Header头部，包括可执行的CPU架构，包括x86，arm64
Load Command 加载命令，包含文件的组织架构和在内存中的布局方式
Data 数据，包含在加载命令中的各个阶段的数据，每一个segment的数据是Page 的整数倍

用Mach-oView打开一个可执行的文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190318101141252.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjc3OTk5Nw==,size_16,color_FFFFFF,t_70)
绝大多数data包含下面3个Segment
__TEXT 只读，包含函数和只读的字符串，上图中的__TEXT都是是代码段
__DATA  读写，数据段，包含可读写的全局变量
__LINKEDIT 包含了数据和变量的元数据，以及代码签名等信息

#### dylb
dynamic loader 加载一个进程所需要的全部Image（上面有介绍）

#### Virtual Memory
虚拟内存是在物理内存上建立的一个逻辑地址空间，它向上提供了一个连续的逻辑地址空间，向下隐藏了物理内存的细节。
虚拟内存使得逻辑地址可以没有实际的物理地址，也可以使得多个逻辑地址指向一个物理地址
虚拟内存被划分为一个个大小相同的Page（64位系统上是16KB），提高管理和读写的效率。 Page又分为只读和读写的Page

#### page fault
当应用被执行时，它被分配的每一个逻辑地址都是可以访问的。当应用访问一个逻辑page，发现这个逻辑page不在物理内存中，就发生了page fault 这个时候会中断当前程序，在物理内存中查找下一个可执行的page，然后从磁盘中读取数据到物理内存接着执行程序

#### Clean Page 和 Dirty Page
只读的page叫做clean page，比如说代码段。读写的page叫做 dirty page 比如说一些data，能够改变数据存储

#### 启动过程
1，加载dyld到APP进程
2，加载动态库（依赖的所有动态库）
3，Rebase
4，Bind
5，加载Objc-c runtime
6，其他初始化代码

dyld会首先加载Mach-O中的header和load command
接着就知道了这个app所依赖的动态库。添加依赖的动态库会按照先填加第一个依赖的动态库A，然后A所依赖的所有动态库，这样递归，直到所有的动态库添加完毕。通常一个App所依赖的动态库有100-400个。大多都是系统的动态库。它们会被缓存到dyld shared cache中，这样大大提高了读取效率。

###### Release & Bind
有两种技术来保证App的安全

ASLR 和 Code Sign
ASLR 全称为 Address space Layout Randomizatiom 字面意思是地址空间随机布局 。App启动的时候程序会被影射到逻辑地址空间。这个逻辑地址空间是有一个其实地址的，如果起始地址不随机布局，很容易被破解。

Code Sign 相信很多人都知道。在对程序进行Code Sign 的时候并不是对整个文件进行哈希加密。而是对每一个page 进行加密。这就保证到当dyld加载到这个page的时候可以对他进行独立验证。

Mach-O中有很多符号，比如果 Printf。有的是指向Mach-O的，有的是指向其他的dylb的。在运行的时候是如何精准的找到print地址的呢
当程序调用printf的时候，会先在__DATA中建立一个指针指向printf ，这个指针通过间接调用dylb通过一些fix-up操作实现找到这些符号的实际地址。
Rebase修正内部指针方向
Rebind修正外部指针方向

###### Objective-C
Objective C是动态语言，所以在执行main函数之前，需要把类的信息注册到一个全局的Table中。同时，Objective C支持Category，在初始化的时候，也会把Category中的方法注册到对应的类中，同时会唯一Selector，这也是为什么当你的Cagegory实现了类中同名的方法后，类中的方法会被覆盖。

另外，由于iOS开发时基于Cocoa Touch的，所以绝大多数的类起始都是系统类，所以大多数的Runtime初始化起始在Rebase和Bind中已经完成

###### Initializer
接下来就是必要的初始化部分了，主要包括几部分：

+load方法。
C／C++静态初始化对象和标记为__attribute__(constructor)的方法
这里要提一点的就是，+load方法已经被弃用了，如果你用Swift开发，你会发现根本无法去写这样一个方法，官方的建议是实用initialize。区别就是，load是在类装载的时候执行，而initialize是在类第一次收到message前调用

#### 启动时间
###### 冷启动和热启动
如果你刚刚启动过app，这时候app启动所需要的数据还在缓存中，再次启动叫做热启动。
缓存中没有app启动所以的数据。启动app时候成为冷启动

启动时间最好不超过400ms
因为从点击app到展示launchScreen，到launchScreen消失的时间为400ms
启动时间不能超过20s，否则会被系统杀死。

在Xcode中，可以通过设置环境变量来查看App的启动时间，```DYLD_PRINT_STATISTICS```和```DYLD_PRINT_STATISTICS_DETAILS```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190318112929342.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjc3OTk5Nw==,size_16,color_FFFFFF,t_70)







