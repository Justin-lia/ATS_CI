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
echo "Setup interfaces."
echo ====================

setupInterfaces


echo ====================
echo "Setup NAT."
echo ====================

setupNat


echo ====================
echo "Setup DNS."
echo ====================

setupDns


echo ====================
echo "Setup HTTP server."
echo ====================

setupHttps


echo ====================
echo "Setup PPPoE server."
echo ====================

setupPppoes_sub


echo ====================
echo "Setup finished."
echo ====================


