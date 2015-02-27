#!/bin/bash

set -e -x

time tftp localhost -c get test.txt test2.txt || \
time tftp localhost -c get test.txt test2.txt

diff -u /srv/tftpboot/test.txt test2.txt && echo "AUTOYAST OK"

