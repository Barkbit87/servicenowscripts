#!/usr/bin/env bash
if [ $# -eq 0 ]; then #If no arguments provided
echo "No arguments provided"
echo "Usage: $0 [FILENAME] [EXPECTED MD5SUM] [user]:[group](optional)"
exit 1

elif [ -z  $2 ]; then #If argument 2 omitted
echo "Missing expected MD5 sum"
echo "Usage: $0 [FILENAME] [EXPECTED MD5SUM] [user]:[group](optional)"
exit 1
fi

FILE_AND_PATH=$1
FILE=$(basename $1) #Get filename from argument
CHECKSUM=$2
USERSTR=$3
if [ -z $USERSTR ]; then #If USRSTR is empty
fiUSERSTR='servicenow:servicenow' #Set default to "servicenow:servicenow"
fi

echo "Checking if MD5 sum matches.."
### Check the MD5SUM provided
FILESUM=($(md5sum -z $FILE_AND_PATH))
if [ "$FILESUM" != "$CHECKSUM" ]; then
    echo "Error! Incorrect md5sum"
    exit 1
fi

echo "Moving file to node root and setting permissions.."
## Move the file to an appropriate location
sudo mv $FILE_AND_PATH ${NODE_DIR:=/glide/nodes/} # Use variable, otherwise set a default location
FILE_AND_PATH=$NODE_DIR$FILE # Set new file and path
sudo chown $USERSTR $FILE_AND_PATH # Set user
sudo chmod u+x $FILE_AND_PATH #Set executable
echo "File operations complete!"
exit 0

EOF