cd yuzu
./cleanup.sh
cd ..
cd jabara
./cleanup.sh
cd ..
cd peel
./cleanup.sh
cd ..
cd seed
./cleanup.sh
cd ..
cd pulp
./cleanup.sh
cd ..
rm -rf initrd.jar log.txt tmp
rm -f bin/fruityos_hdd.img bin/fruityos_floppy.img \
    bin/fruityos_uefi.img bin/fruityos.efi
