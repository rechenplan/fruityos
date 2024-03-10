rm -rf bin
mkdir bin
../../yuzu/yuzu/bin/yc src/fapld.yuzu fapld.s
cat ../../yuzu/yuzu/lib/_start.elf fapld.s src/write_ostab.s ../../yuzu/yuzu/lib/libpith.elf > _.s
../../yuzu/yuzu/bin/zest e _.s bin/fapld
rm _.s fapld.s
sudo ./register.sh
