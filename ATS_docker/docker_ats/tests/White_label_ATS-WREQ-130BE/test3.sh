
filename=$(ls /workspace/tests/White_label_ATS-WREQ-130BE/fw/*.bin)
version=$(echo "$filename" | grep -oP '\d+\.\d+\.\d+\.\d+')
echo $filename
echo $version


#robot --test "FW upgrade Controller" --output report/FW/output.xml --log report/FW/log.html --report report/FW/report.html --variable FW_version:${version} --variable UPLOAD_FILE_PATH:${filename} Fw_upgrade.robot

#robot --exclude Agent --output report/FW/output.xml --log report/FW/log.html --report report/FW/report.html --variable FW_version:${version} --variable UPLOAD_FILE_PATH:${filename} Fw_upgrade.robot

#robot -t "Enable Client wired Network" --output report/FW/output.xml --log report/FW/log.html --report report/FW/report.html --variable FW_version:${version} --variable UPLOAD_FILE_PATH:${filename} Fw_upgrade.robot


#robot --output report/FW/output.xml --log report/FW/log.html --report report/FW/report.html --variable FW_version:${version} --variable UPLOAD_FILE_PATH:${filename} Fw_upgrade.robot

robot --exclude agent --output report/FW/output.xml --log report/FW/log.html --report report/FW/report.html --variable FW_version:${version} --variable UPLOAD_FILE_PATH:${filename} Fw_upgrade.robot
