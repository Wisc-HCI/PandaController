# PandaController
C++ Library for controlling Panda. Primarily designed to be used with the ROS wrapper [panda_ros](https://github.com/Wisc-HCI/panda_ros).


## 1. Prequisites

Here is what you need to start with:
* Ubuntu Machine with the [Real Time Kernel](https://frankaemika.github.io/docs/installation_linux.html#setting-up-the-real-time-kernel)
	* Static IP of 192.168.1.XXX (Ex/ 192.168.1.5) and Netmask of 255.255.255.0 for the ethernet connected to the Panda. For the force torque sensor, the ethernet connected to that needs to be set to a static IP of 192.168.2.XXX (Ex/ 192.168.2.5).
	* [Docker Engine](https://docs.docker.com/engine/install/)
* Franka Emika Panda 7 DOF Robot setup with the [FCI](https://frankaemika.github.io/docs/getting_started.html) and set to static IP of 192.168.1.XXX (Ex/ 192.168.1.3) and Netmask to 255.255.255.0.
	* Robot system version: 4.2.X (FER pandas)
	* Robot / Gripper Server version: 5 / 3
* [Axio80-M20 Force Torque Sensor](https://www.ati-ia.com/products/ft/ft_models.aspx?id=Axia80-M20) installed on the Panda's End Effector and connected to the host computer via ethernet with IP 192.168.2.2 (or change the IP in src/PandaController/src/ForceTorqueListener.cpp).


Here is what we are going to install with docker:
* ROS Noetic
* Libfranka  version 0.9.2
* Various apt/ROS packages 


## 2. Setting Up Your Container

Now  build the container image and start the container. These commands mount on the current directory as the containers file system so any changes you make to the files on your host machine will be mirrored in the container. These commands also allow the containers display to be forwarded to your host machine so that you can see it.
```bash
sudo docker build  -t panda-cpp-controller .

sudo docker run --rm -it --privileged --device=/dev/input/event* --cap-add=SYS_NICE --env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --net=host panda-cpp-controller
```

## 3. Compilation:
```bash
mkdir -p build
cd build
[ -f Makefile ] || cmake ..  # Only initialize if not  already
make install
cd ../..
```



## Resources
* Noetic/Python3 Migration:
	* https://wiki.ros.org/noetic/Migration
	* https://mil.ufl.edu/docs/software/noetic_migration.html
* ROS Headers:
	* https://medium.com/@smilesajid14/how-custom-msg-works-in-ros-7d5a14bf5781
* Force Torque Sensor:
	* https://www.ati-ia.com/app_content/Documents/9610-05-Ethernet%20Axia80.pdf
	* https://www.ati-ia.com/products/ft/ft_models.aspx?id=Axia80-M20
* Force Dimension Input:
	* https://www.forcedimension.com/software/sdk



## Troubleshooting/Testing

* To test if the Force/Torque Sensor is properly connected, go to the sensor's IP (ex/ 192.168.1.6) in a webrowser on your computer. If the ATI Configuration page shows up, that means you are properly connected. If not, reference section 4 of the [Sensor Guide](https://www.ati-ia.com/app_content/Documents/9610-05-Ethernet%20Axia80.pdf). Once you can access the ATI site, you can go to Demo and download the Java application to see the values coming from the sensor.

