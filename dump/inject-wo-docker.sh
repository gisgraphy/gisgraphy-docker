#/bin/bash


if [ ! "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then  echo "this script is only designed to be run on Debian/Ubuntu/Mint"; exit 1; fi

cd ./assets

echo "moving files"
mv dump/* /usr/local/dump/

echo "inject is starting..."
./inject-dump.sh $1 $2 2>&1

echo "inject is finished"

