# N_m3u8DL-RE_ShellGUI
我在issue中只看到有win版的脚本,没有mac的.就自己整了一个,代码水平不高,主打一个能跑就行.
主要是通过shell脚本调用N_m3u8DL-RE进行下载，预设单个下载、批量下载、录播下载。
亲测mac可用，linux按理说应该也没问题，尚未测试。


## 使用说明
能找到这个项目 N_m3u8DL-RE 的使用方式应该就不做过多介绍了
N_m3u8DL-RE_ShellGUI的使用方式和N_m3u8DL-RE_SimpleBatGUI的基本上一模一样,我这边也只是把bat脚本转为了shell脚本.可以参考[N_m3u8DL-RE_SimpleBatGUI](https://github.com/LennoC/N_m3u8DL-RE_SimpleBatGUI)的说明文档

### 补充说明
把m3u8DL.sh 和 imput.txt 这两个文件放到N_m3u8DL-RE主程序的目录下
然后把需要下载的m3u8资源按照 名称$链接 的格式贴在input.txt文件中,多个资源就贴多行.至于为什么是这个格式,我想懂的都懂吧
然后执行sh脚本就开始下载了
下载目录和ffmpeg程序按需配置即可

## 项目说明
本脚本主要是参考@LennoC 大佬的 windows批处理脚本 [N_m3u8DL-RE_SimpleBatGUI](https://github.com/LennoC/N_m3u8DL-RE_SimpleBatGUI) 魔改的sh脚本

## 核心程序
核心程序仍然是@nilaoda 大佬的 [N_m3u8DL-RE](https://github.com/nilaoda/N_m3u8DL-RE) 可以在action中下载最新版的程序
