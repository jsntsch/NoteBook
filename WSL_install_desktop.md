# 在Windows10子系统里安装运行桌面

## 1、Windows安装VcXsrv

启动WSL，并进入微软商城安装Ubuntu
安装好VcXsrv，启动桌面上的XLaunch,选择
`One window without titlebar` 执行

```
sudo apt-get update
sudo apt-get upgrade
```

## 2、WSL安装桌面组件

```
sudo apt-get install xfce4
```

安装xubuntu(安装很漫长)
```
sudo apt-get install xubuntu-desktop
```

## 3、启动xfce4

```
xfce4-session
```

如果报错无法启动，可能是因为没有提前设定DISPLAY

```
export DISPLAY=localhost:0
```

如果此时你出现了跟文章开头一样的界面，就说明已经安装成功了

## 4、制作快捷方式

[StartXUbuntu.bat](自己替换相关路径,用于启动相关程序)

```
start VcXsrv安装目录\vcxsrv.exe  :0 -clipboard -wgl -keyhook -nodecoration
bash -c "cd ~/ && export DISPLAY=localhost:0 && xfce4-session"
```

[XUbuntu.vbs](用于隐藏命令行界面)

```
set ws=WScript.CreateObject("WScript.Shell")
ws.Run "StartXUbuntu.bat的路径",0
```

然后新建一个XUbuntu.vbs的快捷方式，给它换一个图标 *.ico