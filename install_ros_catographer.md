# 一、安装ubuntu mate 16.04
## 1. 下载ubuntu
从官网下载 
[ubuntu_mate_16.04](https://ubuntu-mate.org/raspberry-pi/ubuntu-mate-16.04.2-desktop-armhf-raspberry-pi.img.xz.torrent)
或者
[其他版本](https://ubuntu-pi-flavour-maker.org/download/)
## 2. 刷入ubuntu
这个需要使用工具
[Win32 Disk Mangaer](https://sourceforge.net/projects/win32diskimager/)
，插入读卡机，选择相应的盘符，载入之前下载好的镜像文件，点击write等待写入成功即可完成ubuntu的刷入
## 3. 换软件源
运行以下命令
```
sudo vim /etc/apt/sources.list
```
修改软件源为
```
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial main multiverse restricted universe
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-backports main multiverse restricted universe
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-proposed main multiverse restricted universe
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-security main multiverse restricted universe
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-updates main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-backports main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-proposed main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-security main multiverse restricted universe
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-updates main multiverse restricted universe
```
## 4. 安装ros
```
sudo sh -c 'echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get -y install ros-kinetic-ros-base ros-kinetic-slam-gmapping ros-kinetic-navigation ros-kinetic-xacro ros-kinetic-yocs-velocity-smoother ros-kinetic-robot-state-publisher ros-kinetic-joint-state-publisher ros-kinetic-teleop-twist-*
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```
## 5. 测试结果
安装完成，运行
roscore
可以看到下面输出即可标识完成ros安装

## 6. 开启SSH
1. 打开终端
2. sudo raspi-config
3. 进入第三项
4. 选则p2回车
5. 选择yes回车
6. 等待完成回车确认
7. 退出配置,执行 `ps -e | grep ssh ` ，看到sshd即开启
## 7. 扩展SWAP空间  
先关闭swap
```
cd /var 
sudo swapoff /var/swap 
```
重设swap大小1M*4096=4GB,会花较长时间，请耐心等待 
```
sudo dd if=/dev/zero of=swap bs=1M count=4096
```
格式化 
```
sudo mkswap /var/swap 
```
开启swap
``` 
sudo swapon /var/swap 
```
设置开机启动，在 `/etc/fstab` 文件中添加如下代码 
```
/var/swap swap swap defaults 0 0
``` 
查看当前已生效的swap 
```
swapon -s 
```
查看当前swap使用情况 
```
free -m
```
# 二、安装谷歌cartographer
## 1. 安装编译工具
```
sudo apt-get update
sudo apt-get install -y python-wstool python-rosdep ninja-build
mkdir catkin_ws_carto
cd catkin_ws_carto
wstool init src
wstool merge -t src https://raw.githubusercontent.com/googlecartographer/cartographer_ros/master/cartographer_ros.rosinstall
```
特别说明，在执行 `wstool update -t src` 之前，需要将 `src/.rosinstall` 文件（Ctrl+h显示隐藏文件）修改成 `https://github.com/ceres-solver/ceres-solver.git` ,以解决ceres-solver下载不了的问题   

```
wstool update -t src
```
## 2. 安装依赖项
```
src/cartographer/scripts/install_proto3.sh
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y
```
## 3. 编译和安装
```
catkin_make_isolated --install --use-ninja
source catkin_ws_carto/install_isolated/setup.bash
```
## 4. 运行2D  demo
```
roslaunch cartographer_ros demo_backpack_2d.launch bag_filename:=${HOME}/Downloads/cartographer_paper_deutsches_museum.bag
```
# 三、ROS配置主从机
## 1. 设置固定IP 
    PC主机      IP：192.162.0.113    Name: sch

    树莓派从机   IP：192.162.0.108    Name: raspi
## 2. 从机配置（树莓派配置）
将主机的IP添加到主机的 `/etc/hosts` 这个配置文件里
```
sudo gedit /etc/hosts
```
添加： `192.162.0.113  sch`（也就是打开文件后一般为第三行添加，在一行注释之前）
```
vim ~/.bashrc
```
添加
```
export ROS_MASTER_URI=http://192.162.0.113:11311
export ROS_HOSTNAME=192.162.0.108
```
## 3. 主机配置
将从机的IP添加到主机的 `/etc/hosts` 这个配置文件里
```
sudo gedit /etc/hosts
```
添加：`192.162.0.108  raspi`
```
gedit ~/.bashrc
```
添加： 
```
export ROS_MASTER_URI=http://192.162.0.113:11311         
export ROS_HOSTNAME=192.162.0.108
```
## 4. 测试：（只要主机开启roscore即可）
测试主从机联通: 

    在主机上，ping从机：ping 192.162.0.108
    在从机上，ping主机：ping 192.162.0.113
测试ROS主从配置： 

    主机上，新终端执行：roscore
    从机上，新终端执行：rostopic list
# linux下非root用户获得/dev/ttyUSB×的读写权限
```
raspi@raspi:~$ sudo usermod -aG dialout [raspi]
```
重启
```
reboot
```
# linux下USB口重命名绑定

