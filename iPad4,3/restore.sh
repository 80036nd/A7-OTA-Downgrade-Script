cd iPad4,3
mkdir work
mkdir temp
cd ..
mv iPad_64bit_10.3.3_14G60_Restore.ipsw iPad4,3/1033.ipsw
cd iPad4,3/work
unzip ../1033.ipsw
cd ..
cd temp
git clone https://github.com/MatthewPierson/iPhone-5s-OTA-Downgrade-Patches
cp ../work/Firmware/Mav7Mav8-7.60.00.Release.bbfw baseband.bbfw
cp ../work/Firmware/dfu/iBSS.ipad4.RELEASE.im4p ibss.stock
cp ../work/Firmware/dfu/iBEC.ipad4.RELEASE.im4p ibec.stock
cp ../work/Firmware/all_flash/sep-firmware.j73.RELEASE.im4p sep.im4p
bspatch ibss.stock ibss.patched iPhone-5s-OTA-Downgrade-Patches/ibss_ipad4.patch
bspatch ibec.stock ibec.patched iPhone-5s-OTA-Downgrade-Patches/ibec_ipad4.patch
mv ibss.patched iBSS.ipad4.RELEASE.im4p
mv ibec.patched iBEC.ipad4.RELEASE.im4p
cp iBSS.ipad4.RELEASE.im4p ../work/Firmware/dfu/
cp iBEC.ipad4.RELEASE.im4p ../work/Firmware/dfu/
cd ..
cd ..
./tools/iPwnder32 -p
sleep 3
nonce=$(./tools/igetnonce | grep "ApNonce=.*" -o | cut -c 9-)
echo "Your current ApNonce is $nonce"
ecid=$(./tools/igetnonce | grep "ECID=.*" -o | cut -c 6-)
echo "$ecid"
./tools/tsschecker -m iPad4,3/iPad4,3.plist -e $ecid -d iPad4,3 -s -B j73ap --apnonce $nonce
mv *.shsh blob.shsh2
./tools/irecovery -f tools/blankfile.txt
./tools/irecovery -f iPad4,3/temp/iBSS.ipad4.RELEASE.im4p
./tools/irecovery -f iPad4,3/temp/iBEC.ipad4.RELEASE.im4p
sleep 5
./tools/futurerestore -t blob.shsh2 -p iPad4,3/iPad4,3.plist -s iPad4,3/temp/sep.im4p -m iPad4,3/iPad4,3.plist -b baseband.bbfw iPad4,3/work
echo Cleaning up...
cd iPad4,3
rm -rf temp
rm -rf work
mv *.ipsw ../iPad_64bit_10.3.3_14G60_Restore.ipsw
cd ..
rm -rf blob.shsh2
echo "Press 10 to Exit"
