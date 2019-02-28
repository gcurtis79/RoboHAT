#!/bin/bash

INO_LIST=`find . -maxdepth 1 -type f -iname '*.ino' -printf '%P\n'`
INO_COUNT=`echo $INO_LIST | grep -i .ino | sed 's/.ino /.ino\n/g' | wc -l`

PARAMS=""
while (( "$#" )); do
  case "$1" in
    -f|--flash)
      if [ ! -z $2 ]
      then
        FLASH_HOST=$2
        shift 2
      else
        echo "Must specify [user@]hostname with -f (--flash)"
        exit 1
      fi
      ;;
    -b|--board)
      if [ ! -z $2 ]
      then
        FLASH_BOARD='--board '$2
        shift 2
      else
        echo "Must specify package:arch:board[:paramters] with -b (--board)"
        exit 1
      fi
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

if [ $INO_COUNT -eq 1 ];
then
  if [ -z $FLASH_HOST ]
  then
    /usr/bin/time -f "Build time: %es" arduino $FLASH_BOARD --verify $INO_LIST
  else
    /usr/bin/time -f "Build time: %es" arduino $FLASH_BOARD --verify $INO_LIST && \
    rsync -v -e ssh build/$INO_LIST.hex $FLASH_HOST:~ && \
    #rsh $FLASH_HOST sudo avrdude -p m328p -c linuxspi -P /dev/spidev0.0 -U flash:w:$INO_LIST.hex
    rsh $FLASH_HOST sudo avrdude -p m328p -c linuxgpio -U flash:w:$INO_LIST.hex
  fi
else
  if [ $INO_COUNT -gt 1 ];
  then
    echo "Found multiple sketches"
    echo $INO_LIST | sed 's/.ino /.ino\n/g'
  else
    echo "Did not find a sketch in current directory"
  fi
fi
