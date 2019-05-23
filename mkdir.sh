#!/bin/sh

if [ $# -lt 1 ]
then
  echo "$0 <dir name>"
  exit 1
else
  DIR=$1
fi

if [ ! -d $1 ]
then
  mkdir ${DIR}
fi
touch ${DIR}/.template
