#!/bin/bash
DIR=.
CONF_DIMS=256

bash $DIR/cleanall.sh

#kill all previous dataspaces process 
ps -aux | grep dataspaces| cut -c 9-15|xargs kill -9
ps -aux | grep test| cut -c 9-15|xargs kill -9

rm -f conf cred dataspaces.conf srv.lck

echo "## Config file for DataSpaces
ndim = 2
dims = $CONF_DIMS, $CONF_DIMS

max_versions = 1
lock_type = 2
" > dataspaces.conf

mpirun -n 2 $DIR/dataspaces_server -s 2 -c 4 >&$DIR/server_$CONF_DIMS.log & sleep 2

#mpirun -n 1 $DIR/test_writer DATASPACES 1 2 1 1 $CONF_DIMS $CONF_DIMS 1 1 > $DIR/writer_$CONF_DIMS.log 2>&1 &
#mpirun -n 1 $DIR/test_reader DATASPACES 1 2 1 1 $CONF_DIMS $CONF_DIMS 1 2 > $DIR/reader_$CONF_DIMS.log 2>&1 &

mpirun -n 2 $DIR/test_writer DATASPACES 2 2 2 1 $((CONF_DIMS/2)) $CONF_DIMS 1 1 > $DIR/writer_$CONF_DIMS.log 2>&1 &
mpirun -n 2 $DIR/test_reader DATASPACES 2 2 2 1 $((CONF_DIMS/2)) $CONF_DIMS 1 2 > $DIR/reader_$CONF_DIMS.log 2>&1 &
