#!/bin/bash
cd
git clone --depth=1 https://github.com/raspberrypi/linux
cd linux
KERNEL=kernel8
make bcm2711_defconfig
sed -i "s/CONFIG_LOCALVERSION=\"-v8\"/CONFIG_LOCALVERSION=\"-v8_rt\"/" .config
sed -i "s/CONFIG_PREEMPT=y/# CONFIG_PREEMPT=is not set/" .config
sed -i "s/# CONFIG_PREEMPT_RT is not set/CONFIG_PREEMPT_RT=y/" .config
make -j6 Image.gz modules dtbs
# sudo make -j6 modules_install
# sudo cp /boot/firmware/$KERNEL.img /boot/firmware/$KERNEL-backup.img
# sudo cp arch/arm64/boot/Image.gz /boot/firmware/$KERNEL.img
# sudo cp arch/arm64/boot/dts/broadcom/*.dtb /boot/firmware/
# sudo cp arch/arm64/boot/dts/overlays/*.dtb* /boot/firmware/overlays/
# sudo cp arch/arm64/boot/dts/overlays/README /boot/firmware/overlays/
# sudo reboot