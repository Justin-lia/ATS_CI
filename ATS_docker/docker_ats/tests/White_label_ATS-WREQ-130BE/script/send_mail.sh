cd ~/project/WSR-1166DHPL-ATS/
git pull

rm -rf ~/run_robot_log/*
Xvfb :88 -screen 0 1024x768x16 & export DISPLAY=:88

cafebot.py ~/project/WSR-1166DHPL-ATS/config/config_buffalo.ini ~/project/WSR-1166DHPL-ATS/test_suites/Integrated_Code/WAN_Setting_*.robot ~/project/WSR-1166DHPL-ATS/test_suites/Integrated_Code/Wireless_Function_Test.robot ~/project/WSR-1166DHPL-ATS/test_suites/Integrated_Code/TSB-UIUI*.robot --cafe_result_path ~/run_robot_log/

#~/send_mail_info/dhpL_def2.sh
~/send_mail_info/dhpL_all.sh

sudo export bamboo_recipient=Justin_liao@gemteks.com
cd /etc/barista/repos/cafe/calix/src/cafe/doc_gen/mail_gen/
sudo rm output_previous.xml
sudo mv output.xml output_previous.xml
sudo cp ~/run_robot_log/output.xml .
sudo cp ~/run_robot_log/log.html .
sudo cp ~/report_info_to_shawn.yaml ./report_info.yaml
sudo wkhtmltopdf log.html log.pdf
sudo /opt/ActivePython-2.7/bin/python mail_notification.py output.xml
sudo rm -rf ~/run_robot_log_tmp
sudo cp -a ~/run_robot_log ~/run_robot_log_tmp