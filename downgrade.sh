chmod 777 tools/futurerestore
chmod 777 tools/igetnonce
chmod 777 tools/iPwnder32
chmod 777 tools/irecovery
chmod 777 tools/tsschecker
chmod 777 tools/dependencies.sh
chmod 777 iPhone6,1/restore.sh
chmod 777 iPhone6,2/restore.sh
chmod 777 iPad4,1/restore.sh
chmod 777 iPad4,2/restore.sh
chmod 777 iPad4,3/restore.sh
chmod 777 iPad4,4/restore.sh
chmod 777 iPad4,5/restore.sh
chmod 777 iPad4,6/restore.sh
clear
Selection+=("iPhone6,1")
Selection+=("iPhone6,2")
Selection+=("iPad4,1")
Selection+=("iPad4,2")
Selection+=("iPad4,3")
Selection+=("iPad4,4")
Selection+=("iPad4,5")
Selection+=("iPad4,6")
Selection+=("Install Dependencies" "(Exit)")
Selection+=("Start Over")
echo "*** A7 OTA Downgrade Script ***"
echo "** Select a Supported Device **"
echo ""
select opt in "${Selection[@]}"; do
case $opt in
"iPhone6,1" ) ./iPhone6,1/restore.sh;;
"iPhone6,2" ) ./iPhone6,2/restore.sh;;
"iPad4,1" ) ./iPad4,1/restore.sh;;
"iPad4,2" ) ./iPad4,2/restore.sh;;
"iPad4,3" ) ./iPad4,3/restore.sh;;
"iPad4,4" ) ./iPad4,4/restore.sh;;
"iPad4,5" ) ./iPad4,5/restore.sh;;
"iPad4,6" ) ./iPad4,6/restore.sh;;
"Install Dependencies" ) ./tools/dependencies.sh;;
"Start Over" ) ./downgrade.sh;;
* ) exit 0;;
esac
done
