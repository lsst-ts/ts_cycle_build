# ess-controller

Be patient when this Docker image is building. 
It is based on 64 bit AlmaLinux 8 and both updates of the installed packages and new packages will be downloaded and installed. 
Then Python 3.8 and several Python modules get installed via MambaForge.

The Docker image is intended to run on a Raspberry Pi 4. 
When running a container for the image, a Raspberry Pi with more memory than 1 Gb will give a better performance.

To start the container, issue

docker run -it --name ess-controller --device /dev/ttyUSB0 --device /dev/ttyAMA0 --device /dev/ttyAMA1 --device /dev/ttyAMA2 --device /dev/ttyAMA3 --network host ts-dockerhub.lsst.org/ess-controller:<cycle>
