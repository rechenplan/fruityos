rm -rf initrd
./cleanup.sh
jar.elf c fruityos.jar
juicer.elf c fruityos.jar fruityos.jz
rm fruityos.jar
mkdir initrd
mkdir initrd/src
mv fruityos.jz initrd/src/fruityos.jz
./build.sh
