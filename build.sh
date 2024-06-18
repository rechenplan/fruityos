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
cp ../peel/bin/*.fap bin
cp ../peel/lib/libpith.fap lib/libpith.asm
cp ../peel/lib/_start.fap lib/_start.asm
../peel/bin/jar.elf c initrd.jar
cd ..

cat seed/bin/fdseed.bin pulp/bin/pulp.sys initrd/initrd.jar > fruityos_floppy.img
cat seed/bin/hdseed.bin pulp/bin/pulp.sys initrd/initrd.jar > fruityos_hdd.img

stat --printf="FruityOS size is %s bytes.\n" fruityos_floppy.img
truncate -s 1440K fruityos_floppy.img
truncate -s 64K fruityos_hdd.img
find -regex '.*\.\(yuzu\|asm\|c\)' -print | xargs wc -l > loc.txt

