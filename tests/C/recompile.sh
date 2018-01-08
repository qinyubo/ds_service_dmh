#!/bin/bash

cd /cac/u01/yq47/Documents/dataspaces_service
make clean
make
cd /cac/u01/yq47/Documents/dataspaces_service/tests/C
echo "Recompile done!"
bash /cac/u01/yq47/Documents/dataspaces_service/tests/C/cleanall.sh
