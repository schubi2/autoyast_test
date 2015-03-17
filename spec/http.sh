#!/bin/bash

set -e -x

rcapache2 start

HTTPTEST=/var/log/test-http.txt
HTTPSTEST=/var/log/test-https.txt
HTTPRES=0

echo test > /srv/www/htdocs/test.txt
echo "[DEBUG] http test:"
curl -s -S http://localhost/test.txt 2>&1 | tee $HTTPTEST
echo "[DEBUG] https -k test:"
curl -s -S -k https://localhost/test.txt 2>&1 | tee $HTTPSTEST

diff -u /srv/www/htdocs/test.txt $HTTPTEST && diff -u $HTTPTEST $HTTPSTEST && HTTPRES=1 || echo "[ERROR] HTTP/HTTPS test failed"

test $HTTPRES -eq 1 && echo "AUTOYAST OK"
