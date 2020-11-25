#!/bin/env -S sh

cat << EOF
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: `wc -c installer.lua | cut -f1 -d ' '`

EOF

cat installer.lua

