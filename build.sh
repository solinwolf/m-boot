#!/bin/sh
if [ $# != 0 ]
then
    echo "build.sh takes no argument"
    exit 0
fi

make 
mv -f u-boot.bin bin/
cd bin/
cat E4412_N.bl1.SCP2G.bin bl2.bin all00_padding.bin u-boot.bin tzsw_SMDK4412_SCP_2GB.bin > u-boot-4412.bin
mv -f u-boot-4412.bin ../
rm u-boot.bin	

