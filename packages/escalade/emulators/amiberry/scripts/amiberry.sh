#!/bin/sh

MAX_DRIVES=4
i=0

. /etc/profile
cd /storage/.config/amiberry

emu_start

# Copy over the default configuration
TMP_DIR=/tmp/amiberry
mkdir -p "$TMP_DIR"
cp conf/uaeconfig.uae "$TMP_DIR"/

# Check if we are loading a zip file
if [ `echo $1 | grep -i .zip | wc -l` -eq 1 ]; then
  unzip -q -o "$1" -d "$TMP_DIR"
  # Check for AGA/CD32 game and set configuration options equal to that of an Amiga 1200
  if [ `echo $1 | egrep 'AGA|CD32' | wc -l` -eq 1 -o `echo "$TMP_DIR"/* | egrep 'AGA|CD32' | wc -l` -eq 1 ]; then
    ARGS="chipset=aga \n
          cachesize=0 \n
          finegrain_cpu_speed=1024 \n
          cpu_type=68ec020 \n
          cpu_model=68020 \n
          kickstart_rom_file=/storage/.config/amiberry/kickstarts/kick31.rom"
  fi
  for FILE in "$TMP_DIR"/*
  do
    ARGS="$ARGS\nfloppy$i="$FILE""
    i=$(($i+1))
    # This emulator supports 4 floppies max
    if [ $i -eq $MAX_DRIVES ]; then
      break;
    fi
  done
  echo -e $ARGS >> "$TMP_DIR"/uaeconfig.uae
  $PASUSPENDER amiberry -f "$TMP_DIR"/uaeconfig.uae > /var/log/amiberry.log 2>&1
  rm -rf "$TMP_DIR"
else
  # Check for AGA game
  if [ `echo $1 | egrep 'AGA|CD32' | wc -l` -eq 1 -o `echo "$TMP_DIR"/* | egrep 'AGA|CD32' | wc -l` -eq 1 ]; then
    ARGS="chipset=aga\ncachesize=0\nchipmem_size=4\nfinegrain_cpu_speed=1024\ncpu_type=68ec020\ncpu_model=68020\nkickstart_rom_file=/storage/.config/amiberry/kickstarts/kick31.rom"
  fi
  echo -e "$ARGS\nfloppy0=$1" >> "$TMP_DIR"/uaeconfig.uae
  $PASUSPENDER amiberry -f "$TMP_DIR"/uaeconfig.uae > /var/log/amiberry.log 2>&1
fi

emu_stop
