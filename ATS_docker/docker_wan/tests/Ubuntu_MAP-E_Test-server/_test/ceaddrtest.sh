#!/bin/bash

#
# Include files
#

. "./sub_routine.sh"


#
# Main
#

cd ./https

## SrvPrefix=240b:0251:0220:1b00

Compprefv6 = `cat get_rules.json | jq -r .fmr[1].ipv6`
## Compprefv6 = 240b:251::/32




