echo -1 >/proc/sys/fs/binfmt_misc/fap
echo ":fap:E::fap::$PWD/bin/fapld:" | tee /proc/sys/fs/binfmt_misc/register
