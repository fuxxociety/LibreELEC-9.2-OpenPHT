#!/bin/sh

# Created by github.com/escalade

do_mount() {
  NAME=`basename $1`
  DEVICE=`losetup -f --show $1`
  echo $DEVICE > /tmp/.luksmount-$NAME
  cryptsetup open $DEVICE $NAME 2>&1
  mkdir -p /media/$NAME
  mount -t btrfs -o compress=lzo,noatime /dev/mapper/$NAME /media/$NAME
  /usr/lib/samba/samba-autoshare
  echo "Mounted $1 on /media/$NAME."
}

do_umount() {
  NAME=`basename $1`
  if [ ! -f /tmp/.luksmount-$NAME ]; then
    echo "Not mounted."
    exit 1
  fi
  DEVICE=`cat /tmp/.luksmount-$NAME`
  umount /media/$NAME
  rmdir /media/$NAME
  cryptsetup close $NAME
  losetup -d $DEVICE
  /usr/lib/samba/samba-autoshare
  rm /tmp/.luksmount-$NAME
  echo "Unmounted $1."
}

do_create() {
  dd if=/dev/urandom of=$1 bs=1M count=$2
  DEVICE=`losetup -f --show $1`
  NAME=`basename $1`
  echo
  echo "Creating LUKS container..."
  cryptsetup -q luksFormat $DEVICE > /dev/null 2>&1
  echo
  echo "Opening LUKS container..."
  cryptsetup open $DEVICE $NAME 2>&1
  mkfs.btrfs -L $NAME /dev/mapper/$NAME
  cryptsetup close $NAME
  losetup -d $DEVICE
  echo "Created a $2MB large LUKS container with BTRFS filesystem at $1."
}

show_usage() {
  echo
  echo " To create an image:"
  echo "   $0 create filename megabytes"
  echo
  echo " To mount or unmount an image:"
  echo "   $0 [mount|umount] filename"
  echo
  echo " Example:"
  echo "   $0 create /storage/example.img 1024"
  echo "   $0 mount /storage/example.img"
  echo
}

case $1 in
  mount)
    if [ ! $# = 2 ]; then
      show_usage
      exit 1
    fi
    do_mount $2
    ;;
  umount|unmount)
    if [ ! $# = 2 ]; then
      show_usage
      exit 1
    fi
    do_umount $2
    ;;
  create)
    if [ ! $# = 3 ]; then
      show_usage
      exit 1
    fi
    do_create $2 $3
    ;;
  *)
    show_usage
esac
