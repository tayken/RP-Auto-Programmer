#!/bin/bash
set -eu

eval $(udevadm info --query=env --export /${1})
PARTITION=${DEVNAME}
LOG_FILE="$(date -u +'%FT%TZ').log"
BASE_PATH=<path>
LOG_PATH=${BASE_PATH}/logs
BUILD_PATH=${BASE_PATH}/build

mkdir -p ${LOG_PATH}
${BUILD_PATH}/rp-program.sh ${PARTITION} >> ${LOG_PATH}/${LOG_FILE}
