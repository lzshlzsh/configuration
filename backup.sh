#!/bin/bash
set -e

DIR=`cd $(dirname $0) && pwd`

cp -fv /etc/bashrc $DIR/
df -h >$DIR/df.txt
cp -fv /etc/fstab $DIR/
ls -l /etc/grub* >$DIR/grub.txt

pvdisplay >$DIR/lvm.txt
lvdisplay >>$DIR/lvm.txt
vgdisplay >>$DIR/lvm.txt

ls -l /opt/ /usr/local/ >$DIR/opt_usr_local.txt

