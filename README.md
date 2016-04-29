# LXAppFrameworkDemo
一个基于MVC的工程框架
---
* 自定义tabbar
* 实现了引导页
* 给AppDelegate.m中的代码瘦身，把一些初始化工作放到AppStart.m中
* 使用[https://github.com/JNTian/JTNavigationController](https://github.com/JNTian/JTNavigationController)实现了全屏滑动返回，可以在需要关闭的页面单独关闭。修改该框架内容（增加了present方法）
* 未加其他第三方库
* 未做iOS9适配
* 添加部分宏定义

---
建议
* 网络层根据接口返回数据内容选择 集约型 或者 离散型 网络层设计。简单接口用集约型，复杂接口用离散型。
* view层简单界面用xib或sb，复杂界面用代码（我自己的习惯）

