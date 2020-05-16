#!/bin/bash
# uppercase.sh : Changes input to uppercase.

cat $1 | tr 'a-z' 'A-Z'
#  Letter ranges must be quoted
#+ to prevent filename generation from single-letter filenames.

exit 0
