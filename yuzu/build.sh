rm -rf bin
echo "[ Building yuzu ]"
mkdir bin
cd src
cd byc
./build.sh
cd ../
cd zest
./build.sh
cd ../
cd yc
./build.sh
cd ../
