#!/bin/sh

BASEPATH=$(cd $(dirname $0); pwd)
echo $BASEPATH

BASEPATH=$(dirname $(readlink -f $0))
echo $BASEPATH
