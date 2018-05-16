# BlockCacheSim

### Download & Compile

* Download via the following command
```
git clone https://github.com/zydirtyfish/BlockCacheSim.git
```

* Enter the BlockCacheSim directory, and use command ```make``` to compile

* Use command ```make run``` to execute the sample program

### To download the trace file

* The sample program uses the trace file ```example.csv``` under the directory ```trace```. You can get more trace file from [UMassTraceRepository](http://traces.cs.umass.edu/index.php/Storage/Storage) or [SNIA Website](http://iotta.snia.org/tracetypes/3). You can match the trace file format by adjusting the trace_type in the configuration file.

### Configuration file
* All the configuration information of BlockCacheSim is in the file ```config```, it uses equals sign to connnect the config attributes and their values. 
* Comments begin with #
```
#algorithm type
algorithm_type=0
#cache size
block_num_conf=65536
#block size
block_size_conf=4096
#write strategy
write_algorithm_conf=1

#the name of the log file
log_prefix=./trace/example.csv

#lazy parameters
PARA=4
k=16
```

程序入口在cache-sim.cpp中的main函数，可以发现，配置文件通过命令行参数传入，即通过下列命令运行
```
./cache-sim.o config
```

### 统计trace的基本信息
```
./cache-sim.o config 100
```

### 缓存的初始化

```
init_cache()//函数读取配置文件并对缓存进行初始化
destroy_cache()//销毁缓存
```


### 运行缓存
main()函数通过调用Run对象的exec()方法运行缓存,exec()函数调用了Algorithm类中的kernel()方法。因此kernel()是整个cache-sim的核心方法。

不同的缓存替换算法都继承了Algorithm这个算法父类，并且实现了父类中的虚函数map_operation()，kernel()函数通过调用不同的map_operation()实现不同的替换策略，这一点类似于flashcache的实现，flashcache实现的就是map_operation()所实现的功能，而kernel()则类似于device-mapper层提供的转发功能。

### 结果显示
![image](http://onx1obrfu.bkt.clouddn.com/joystorage/blogs/缓存模拟器-cache-sim1.jpg)

### 输出样例
![image](http://onx1obrfu.bkt.clouddn.com/joystorage/blogs/缓存模拟器-cache-sim2.jpg)

### 增加算法
- 先照着lru.h的模板新建一个替换算法的头文件x.h,然后修改算法中map_operation()函数的逻辑
- 修改完x.h头文件后，在cache-sim.h头文件中缓存算法配置区的位置添加一行x替换算法的定义 #define X n。其中X为算法的名称，n为正整数，但不能与之前的定义整数重复。
- 最后修改run.h头文件，首先需要引入头文件#include "x.h"。然后在Run类的私有成员变量中添加一个X的对象__X * x，然后修改RUN()函数的初始化算法类部分代码。最后修改exec()函数缓存操作部分代码。

### 关于我们
张煜

华中科技大学
武汉光电国家实验室
计算机系统结构
2016级研究生

### 更新
cache-sim还将会实现更多最新的替换算法，敬请期待！

### 声明
非商业转载请注明作者及出处。商业转载请联系作者本人。
