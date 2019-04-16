arc4random()这个全局函数会生成10位数的随机数大小为0-2^32-1

下面使用acr4random（）生成一个1-100的随机数
```
let temp = Int(arc4random()%100)+1
```
下面使用acr4random_uniform()生成一个1-100的随机数
```
let temp = Int(arc4random_uniform(100))+1
```

