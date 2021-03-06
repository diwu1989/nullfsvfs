dmesg -c > /dev/null
umount /my/
rmmod nullfs
insmod nullfs.ko

mount -t nullfs none /my/

cp /etc/fstab /my/fstab
stat -c'%n      size: %s blocks:%b' /etc/fstab
stat -c'%n      size: %s blocks:%b' /my/fstab

mkdir /tmp/testdir 2>/dev/null
mkdir /my/testdir
stat -c'%n      size: %s blocks:%b' /tmp/testdir
stat -c'%n      size: %s blocks:%b' /my/testdir


for FILE in `echo /my/file /tmp/file`; do
	dd if=/dev/zero of=$FILE bs=1024 count=2000>/dev/null 2>&1
	stat -c'%n	size: %s blocks:%b' $FILE
done

grep nullfs /proc/mounts
umount /my/
rmmod nullfs
insmod nullfs.ko
mount -t nullfs none /my/ -o write=fstab
cp /etc/fstab /my/fstab
dmesg| tail -n 5

echo TEST > /sys/fs/nullfs/exclude
cp /etc/passwd /my/TEST
wc -l /my/TEST
cp /etc/passwd /my/BAZ
wc -l /my/BAZ

