#!/bin/bash

#
# Include files
#

. "./sub_routine.sh"


#
# Main
#
echo ====================
echo "create fw check list and download link."
echo ====================
cd ./autoupdates

> $AutoUpTxt

sed -e "s/<fw_AutoUpBin0>/${AutoUpBin[0]}/g" -e "s/<fw_AutoUpHtml>/$AutoUpHtml/g"  check_list_base.txt > $AutoUpTxt

cp releasenote.html $AutoUpHtml

cd ..

echo ====================
echo "Setup Auto Update server."
echo ====================

setupAutoupdates


