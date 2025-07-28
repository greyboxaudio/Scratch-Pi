#!/bin/bash
# update system and install dependencies
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y vim libmpg123-dev cpufrequtils build-essential cdparanoia mpg123 ffmpeg \
build-essential libasound2-dev libasound2 libsdl-ttf2.0-dev libsdl1.2-dev libsdl2-ttf-dev \
fonts-dejavu git screen bc bison flex libssl-dev make libc6-dev libncurses5-dev
sudo apt autoremove -y
# add user to audio group
sudo usermod -aG audio $USER
# Set scaling governor to performance
sudo tee /etc/default/cpufrequtils <<EOL
ENABLE="true"
GOVERNOR="performance"
MAX_SPEED="0"
MIN_SPEED="0"
EOL
# configure realtime priorities
sudo tee /etc/security/limits.d/audio.conf <<EOL
@audio - rtprio 90       # maximum realtime priority
@audio - memlock unlimited  # maximum locked-in-memory address space (KB)
EOL
# download and install xwax
cd
git clone https://xwax.org/devel/xwax.git
cd xwax
./configure --prefix /usr --enable-alsa
make clean
make
sudo make install
cd
# disable unnecessary services
sudo systemctl disable ModemManager
sudo systemctl disable bluetooth.service
sudo systemctl disable cups
sudo systemctl disable cups-browsed
# configure boot behaviour
sudo raspi-config nonint do_boot_splash 0
sudo raspi-config nonint do_boot_behaviour B2
# reboot
sudo reboot