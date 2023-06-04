# 这是一门用C语言编写的脚本语言
接近90%的代码已经在[《基于C语言自制编程语言》](https://book.douban.com/subject/30311070/)这本书中完成, 我又在其上修复了我看见的bug，解决了内存泄漏问题，最重要的加上了大量的单元测试，以及添加了更多的功能(switch,elseif,字段默认的getter,setter,更友好的报错信息,解除函数需要显示指定"call"调用的限制,写回操作符,后缀操作符)使它更像我们平时熟悉的脚本语言(比如JavasScript)

## Feature
 - [面向对象](./tests/inheritance.sp)
 - [协程](./tests/multithreaded_test.sp)
 - [标准库](./tests/map_hashobj.sp)
 - [闭包](./tests/map_hashobj.sp)
 - [操作符重写](./tests/operator_overload.sp)
 - 模块化
 - GC
 - 基于栈式的虚拟机
 - 更多功能请看测试用例

## 编译与构建
- 开发环境Ubuntu18.04(WSL)
- gcc
- make

## 测试
在项目根目录下运行即可`make test`

## 调试
如果你用的编辑器是vscode可以在项目根目录下建立`.vscode`文件夹
在其中新建一个`launch.json`, 其中`program`字段就是要调试的可执行文件
`args`字段是一个数组它是要传给可执行文件的参数，配置好`launch.json`后
并且GDB已经安装的话按F5即可开始调试。
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Linux GDB",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/spr",
            "args": ["samples/a.sp"],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "console": "externalTerminal",
            "MIMode": "gdb",
            "setupCommands": [
                {"text":"handle SIGUSR1 nostop noprint"},
            ]
        }
    ]
  }
```

## 代码报红
如果你用的编辑器是vscode,那是因为编辑器将C的头文件按照C++解析了，可以在`.vscode`中新建`settings.json`,在这个文件里显示指明文件是C文件即可，比如下面的json就指明了`obj_thread.h`是C文件
```json
{
    "files.associations": {
        "obj_thread.h": "c",
    }
}
```