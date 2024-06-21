cd yuzu
./build.sh
cd ..
cd peel
./build.sh
cd ..
cd seed
./build.sh
cd ..
cd pulp
./build.sh
cd ..


echo [ Creating initial RAM filesystem ]
mkdir initrd
cd initrd

mkdir bin
mkdir src

cp ../peel/bin/*.fap bin
cp ../scripts/init.psh init.psh
../peel/bin/jar.elf c initrd.jar
mv initrd.jar ../
cd ..

cat seed/bin/hdseed.bin pulp/bin/pulp.sys initrd.jar > fruityos_hdd.img
stat --printf="FruityOS size is %s bytes.\n" fruityos_hdd.img
truncate -s 256K fruityos_hdd.img
find -regex '.*\.\(yuzu\|asm\|c\)' -print | xargs wc -l > loc.txt

rm -f initrd.jar
