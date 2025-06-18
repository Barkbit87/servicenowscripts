#!/usr/bin/env bash
if [ $# -eq 0 ]; then
echo "No arguments provided"
echo "Usage: verifyAndMovePackage.sh [FILENAME] [EXPECTED MD5SUM]"
exit 1
fi

FILE="$1"
CHECKSUM="$2"
# Check the MDSUM provided
FILESUM=($(md5sum -z $FILE))
if [ "$FILESUM" != "$CHECKSUM" ]; then
    echo "Error! Incorrect md5sum"
    exit 1
fi
echo "Success!"
exit 0