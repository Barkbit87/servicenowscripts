#!/usr/bin/env bash
if [ $# -eq 0 ]; then
echo "No arguments provided"
echo "Usage: $0 [FILENAME] [EXPECTED MD5SUM] [user]:[group]"
exit 1
fi

FILE_AND_PATH=$1
FILE=$(basename $1)
CHECKSUM=$2
USERSTR=$3
if [ -z $USERSTR ]; then
USERSTR='servicenow:servicenow' #Set user and group, default to "servicenow:servicenow"
fi

### Check the MD5SUM provided
FILESUM=($(md5sum -z $FILE_AND_PATH))
if [ "$FILESUM" != "$CHECKSUM" ]; then
    echo "Error! Incorrect md5sum"
    exit 1
fi

## Move the file to an appropriate location
sudo mv $FILE_AND_PATH ${NODE_DIR:=/glide/nodes/} # Use variable, otherwise set a default location
FILE_AND_PATH=$NODE_DIR$FILE # Set new file and path
sudo chown $USERSTR $FILE_AND_PATH # Set user
sudo chmod u+x $FILE_AND_PATH #Set executable
echo "File operations complete!"
exit 0

EOF