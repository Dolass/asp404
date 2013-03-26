系统要求
-----
* 支持 Scripting.FileSystemObject
* 支持 Scripting.Dictionary
* 支持 ADODB.Stream
* 支持 ScriptControl
* 支持 自定义404/405

如何安装
-----
* 设置自定义 404错误 为URL指向 "/Index.ASP"
* 设置自定义 405错误 为URL指向 "/Index.ASP"
* 安装完成


文件说明
-----
    ├─ Index.ASP    //程序入口
	│ 
    ├─ CORE         //系统内核
	│   │
	│   ├─ Base.ASP         //程序基本设置
	│   ├─ Cache.ASP        //缓存类 [尚未开发]
	│   ├─ DB.ASP           //DB操作
	│   ├─ Function.ASP     //系统函数库
	│   ├─ Router.ASP       //URL解析与动态调用的实现 [核心]
	│   ├─ System.ASP       //系统配置与接口
	│   └─ Theme.ASP        //模版
	│ 
    ├─controller    //默认控制器目录, 文件名与类名一致 ClassName.ASP / ClassName, 所有 Method 不带参数
	│ 
    ├─database      //默认数据目录
	│ 
    ├─style         //默认模版目录
	│ 
    ├─Config.ASP    //目录、数据库、调试开关等设置
	│ 
    └─htaccess.ASP  //Url正则Rewrite

其他
-----
当前版本为demo, 框架本身十分精简和灵活，基础功能已全部实现, 具体说明查看代码即可。Cachce部分正在考虑是否有必要开发

![index.index()](https://raw.github.com/superos/asp404/master/snap-1.png "Optional title")
![index.hello()](https://raw.github.com/superos/asp404/master/snap-2.png "Optional title")
![index.error404()](https://raw.github.com/superos/asp404/master/snap-3.png "Optional title")
![index.notset()](https://raw.github.com/superos/asp404/master/snap-4.png "Optional title")
