#!/bin/bash

#
# Include files
#

. "./sub_routine.sh"


#
# Main
#

echo ====================
echo "Stop current daemons."
echo ====================

stopDaemons


echo ====================
echo "Restart Network Manager."
echo ====================

## original link is...: /etc/resolv.conf -> ../run/resolvconf/resolv.conf
ln -fs /run/resolvconf/resolv.conf /etc/

service network-manager restart

