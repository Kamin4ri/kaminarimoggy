echo -e "Making moto g 3g (falcon) zImage\n"
export PATH=$HOME/toolchains/Linaro4.9.3-CortexA7-arm-eabi/bin:$PATH
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=arm-cortex_a7-linux-gnueabihf-

make falcon_defconfig

make -j4

# make directories if they don't exist
if [ ! -d ../zip ] ; then mkdir ../zip; fi;
if [ ! -d ../zip/kernel ] ; then mkdir ../zip/kernel; fi;
if [ ! -d ../zip/system ] ; then mkdir ../zip/system; fi;
if [ ! -d ../zip/system/lib ] ; then mkdir ../zip/system/lib; fi;
if [ ! -d ../zip/system/lib/modules ] ; then mkdir ../zip/system/lib/modules; fi;
if [ ! -d ../zip/system/lib/modules/pronto ] ; then mkdir ../zip/system/lib/modules/pronto; fi;

# modules
find ./ -type f -name '*.ko' -exec cp -f {} ../zip/system/lib/modules/ \;
mv ../zip/system/lib/modules/wlan.ko ../zip/system/lib/modules/pronto/pronto_wlan.ko

# copy zImage
cp -f arch/arm/boot/zImage-dtb ../zip/kernel/
ls -l ../zip/kernel/zImage-dtb
cd ../zip
zip -r -9 Kaminari-vN.zip * > /dev/null
mv Kaminari-vN.zip ../
