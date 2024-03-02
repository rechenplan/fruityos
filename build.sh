mkdir bin
../yuzu/bin/yc src/fapld.yuzu fapld.s
cat ../yuzu/lib/_start.elf fapld.s ../yuzu/lib/libpith.asm > _.s
../yuzu/bin/zest e _.s bin/fapld
rm _.s fapld.s
sudo ./register.sh
