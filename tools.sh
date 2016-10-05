#!/bin/bash
#set -e

DIR=`cd $(dirname $0) && pwd`
cd $DIR

declare -A SYMLINK_MAP

function backup() 
{
    cp -fv /etc/bashrc . 
    df -h >df.txt
    cp -fv /etc/fstab .
    ls -l /etc/grub* >grub.txt

    pvdisplay >lvm.txt
    lvdisplay >>lvm.txt
    vgdisplay >>lvm.txt

    ls -l /opt/ /usr/local/ >opt_usr_local.txt

    dnf list installed >installed.txt

    crontab -l -u root >root.crontab
    crontab -l -u lzs >lzs.crontab
}

function get_symlink()
{
    if [ $# -ne 1 ]; then
        echo "get_symlink file"
        return 1
    fi

}

function restore()
{
    if ! [ -h /etc/yum.repos.d ] || 
        [ "x`readlink /etc/yum.repos.d`" != "x/data/github/configuration/yum.repos.d" ]; then
        rm -rfv /etc/yum.repos.d
        ln -snf /data/github/configuration/yum.repos.d /etc
    fi
}

if [ $# -ne 1 ]; then
    echo "$0 <backup|restore>"
    exit 0
fi

case "x$1" in
    "xbackup")
        backup
        ;;
    "xrestore")
        restore
        ;;
    *)
        echo "$0 <backup|restore>"
        exit 0
        ;;
esac

