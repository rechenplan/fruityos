echo Building yuzu...
cd yuzu
./build.sh
cd ..
echo Building peel...
cd peel
./build.sh
cd ..
echo Building seed...
cd seed
./build.sh
cd ..
echo Building pulp...
cd pulp
./build.sh
cd ..

echo Creating initial RAM filesystem...
rm -rf initrd
mkdir initrd
cd initrd
mkdir lib
mkdir bin
mkdir src
mkdir src/bin
cp ../peel/bin/*.fap bin
cp ../peel/lib/libpith.fap lib/libpith.asm
cp ../peel/lib/_start.fap lib/_start.asm
cd ../peel/src
../bin/jar.elf c peel.jar
../bin/juicer.elf c peel.jar peel.jar.jz
cd ../../initrd
cp ../peel/build.psh src
cp ../peel/src/peel.jar.jz src
../peel/bin/jar.elf c initrd.jar
cd ..
rm -rf peel/src/peel.jar
rm -rf peel/src/peel.jar.jz

cat seed/bin/fdseed.bin pulp/bin/pulp.sys initrd/initrd.jar > fruityos_floppy.img
cat seed/bin/hdseed.bin pulp/bin/pulp.sys initrd/initrd.jar > fruityos_hdd.img

stat --printf="FruityOS size is %s bytes.\n" fruityos_floppy.img
truncate -s 1440K fruityos_floppy.img
truncate -s 128K fruityos_hdd.img
find -regex '.*\.\(yuzu\|asm\|c\)' -print | xargs wc -l > loc.txt

