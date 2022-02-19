cd tools
mkdir dependencies
cd dependencies
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone https://github.com/tihmstar/libirecovery
cd libirecovery
brew install libtool automake lsusb openssl libzip pkg-config
./autogen.sh
make
make install
cd ..
cd ..
rm -rf dependencies
clear
echo "*** Press 11 to start over or 10 to exit ***"
