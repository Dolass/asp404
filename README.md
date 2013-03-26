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

默认首页，用bootstrap实现的一个登录框，通过 Sys.Server("HTTP_METHOD") 实现分离GET和/POST
![index.index()](https://raw.github.com/superos/asp404/master/snap-1.png "index")

所有类的方法都不带参数的，参数通过Router类解析之后提取到 Sys.Agrvs，实现ASP中 可选参数 的概念
![index.hello()](https://raw.github.com/superos/asp404/master/snap-2.png "hello/jason && hello/")

通过htaccess.asp中设置正则规则，所有未处理的请求都定向到自己的404页面上 
![index.error404()](https://raw.github.com/superos/asp404/master/snap-3.png "404 Error")

未定向到404 同时又未定义的方法 被请求时会提示未定义错误
![index.notset()](https://raw.github.com/superos/asp404/master/snap-4.png "undefined class.method")
