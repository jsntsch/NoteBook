## 1、安装依赖
```
sudo apt update
sudo apt install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt install -y python2.7-dev
sudo apt install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
sudo apt install -y libv4l-dev v4l-utils qv4l2 v4l2ucp
sudo apt install -y curl unzip
sudo apt update
```
## 2、下载源码
```
mkdir -p ~/tools/
cd ~/tools/
curl -L https://github.com/opencv/opencv/archive/3.4.0.zip -o opencv-3.4.0.zip
unzip opencv-3.4.0.zip 
cd opencv-3.4.0/
```
## 3、下载contrib模块
```
curl -L https://github.com/opencv/opencv_contrib/archive/3.4.0.zip -o opencv_contrib-3.4.0.zip
unzip opencv_contrib-3.4.0.zip
```
## 4、下载ippicv
```
cd 3rdparty/ippicv/
curl -L https://github.com/opencv/opencv_3rdparty/raw/ippicv/master_20170822/ippicv/ippicv_2017u3_lnx_intel64_general_20170822.tgz -o ippicv_2017u3_lnx_intel64_general_20170822.tgz
sudo vim ippicv.cmake
```
修改ippicv地址为  ` "file://~/tools/opencv-3.4.0/3rdparty/ippicv/" `
```
cd ../../
```
## 5、编译安装
```
mkdir build
cd build/
cmake -D ENABLE_PRECOMPILED_HEADERS=OFF -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=~/tools/opencv-3.4.0/opencv_contrib-3.4.0/modules ..
make -j2
sudo make install
```
## 6、链接动态库
```
sudo vim /etc/ld.so.conf.d/opencv.conf 
```
wrote  ` /usr/local/lib/ `  to  ` opencv.conf `  file
```
sudo ldconfig -v
```