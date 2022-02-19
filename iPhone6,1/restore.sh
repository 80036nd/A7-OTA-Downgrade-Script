cd iPhone6,1
mkdir work
mkdir temp
cd ..
mv iPhone_4.0_64bit_10.3.3_14G60_Restore.ipsw iPhone6,1/1033.ipsw
cd iPhone6,1/work
unzip ../1033.ipsw
cd ..
cd temp
git clone https://github.com/MatthewPierson/iPhone-5s-OTA-Downgrade-Patches
cp ../work/Firmware/Mav7Mav8-7.60.00.Release.bbfw baseband.bbfw
cp ../work/Firmware/dfu/iBSS.iphone6.RELEASE.im4p ibss.stock
cp ../work/Firmware/dfu/iBEC.iphone6.RELEASE.im4p ibec.stock
cp ../work/Firmware/all_flash/sep-firmware.n51.RELEASE.im4p sep.im4p
bspatch ibss.stock ibss.patched iPhone-5s-OTA-Downgrade-Patches/iBSS.normal.patch
bspatch ibec.stock ibec.patched iPhone-5s-OTA-Downgrade-Patches/iBEC.normal.patch
mv ibss.patched iBSS.iphone6.RELEASE.im4p
mv ibec.patched iBEC.iphone6.RELEASE.im4p
cp iBSS.iphone6.RELEASE.im4p ../work/Firmware/dfu/
cp iBEC.iphone6.RELEASE.im4p ../work/Firmware/dfu/
cd ..
cd ..
./tools/iPwnder32 -p
sleep 3
nonce=$(./tools/igetnonce | grep "ApNonce=.*" -o | cut -c 9-)
echo "Your current ApNonce is $nonce"
ecid=$(./tools/igetnonce | grep "ECID=.*" -o | cut -c 6-)
echo "$ecid"
./tools/tsschecker -m iPhone6,1/iPhone6,1.plist -e $ecid -d iPhone6,1 -s -B n51ap --apnonce $nonce
mv *.shsh blob.shsh2
./tools/irecovery -f tools/blankfile.txt
./tools/irecovery -f iPhone6,1/temp/iBSS.iphone6.RELEASE.im4p
./tools/irecovery -f iPhone6,1/temp/iBEC.iphone6.RELEASE.im4p
sleep 5
./tools/futurerestore -t blob.shsh2 -b iPhone6,1/temp/baseband.bbfw -p iPhone6,1/iPhone6,1.plist -s iPhone6,1/temp/sep.im4p -m iPhone6,1/iPhone6,1.plist iPhone6,1/work
echo Cleaning up...
cd iPhone6,1
rm -rf temp
rm -rf work
mv *.ipsw ../iPhone_4.0_64bit_10.3.3_14G60_Restore.ipsw
cd ..
rm -rf blob.shsh2
echo "Press 10 to Exit"
