# ubuntu-qt-5.4
Docker image for running QT 5.4 on Ubuntu 16.04.
Image included
+ QT 5.4.0
+ QtCreator

# Usage
* To build, execute
```
cat qt540.tar.xz.* > qt540.tar.xz

./docker-build.sh
```
* To run, execute
```
./docker-run.sh
```
* To use the *QtCreator.desktop* file
** Check out the project into a folder, ex: /opt/ubuntu-qt-5.4
** Copy the file *QtCreator.desktop* into the Desktop folder
** Edit the file
```
Exec=gnome-terminal -e /opt/ubuntu-qt-5.4/docker-run.sh
Icon=/opt/ubuntu-qt-5.4/qtcreator.png
```
