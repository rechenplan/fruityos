echo "[ Building FruityOS bootloader ]"
rm -rf bin
mkdir bin
cd src
cd fdseed
./build.sh
cd ..
cd hdseed
./build.sh
cd ..
cd ..
