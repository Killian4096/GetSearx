#Overview
A simple script to allow anyone to easily install a searx instance onto their Debian system, whether desktop, server, or virtual machine.

#Install
On your Debian system, first install git:
```sh
sudo apt-get install git
```

Next clone the repo:
```sh
git clone https://github.com/Killian4096/GetSearx
```

Next, run the install script:
```sh
sudo sh install.sh
```
This will begin the install process.

You will be promted to bind the ip of the searx instance. If you are running this on a server or virtual machine, type the ip of the server or virtual machine. If this is being run on your main machine simply hit enter. 

You will also be prompted to install a cronjob, which allows the searx instance to begin on startup. If you wish for this, select yes and reboot. If not, you may run the searx instance manually:
```sh
sudo sh searx-webapp.sh
```

If you installed as a cronjob simply reboot and your searx instance should be accessable by typing into your browser:
```
127.0.0.1:888
```
Replacing 127.0.0.1 with the ip you have binded it to, or keeping it the same if this is your main machine.
