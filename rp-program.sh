#!/bin/bash
set -eu

PARTITION=${1}
SCRIPT_PATH=$(pwd)

echo "Check if partition is mounted and mount if not"
findmnt -S ${PARTITION} > /dev/null || udisksctl mount -b ${PARTITION}

echo "Find mount path"
MNT_PATH=$(findmnt -S ${PARTITION} -no TARGET)

echo "Copy uf2 file"
cp ${SCRIPT_PATH}/*.uf2 ${MNT_PATH}
