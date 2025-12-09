



#
#robot -d log --test "FW upgrade Controller" FW_upgrade.robot
#robot --exclude agent --output report/FW/output.xml --log report/FW/log.html --report report/FW/report.html --variable FW_version:${version} --variable UPLOAD_FILE_PATH:/workspace/tests/White_label_ATS-WREQ-130BE/WNRFQQ-113BE-v1.1.03.033.bin Fw_upgrade.robot

robot -d log --test "FW upgrade Controller" --variable FW_version:"1.1.03.039" --variable UPLOAD_FILE_PATH:"/workspace/tests/White_label_ATS-WREQ-130BE/WNRFQQ-113BE-v1.1.03.033.bin" Fw_upgrade.robot
