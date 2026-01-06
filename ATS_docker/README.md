markdown
```shell
├── README.md
├── start_env.sh
├── interface_vlan_set.sh
├── remove_vlan_interface.sh
├── fix_interface_name_wan.sh
├── fix_interface_name_lan.sh
├── fix_interface_name_ats.sh
├── config.sh
├── docker_ats/
├── docker_lan/
└── docker_wts/
```

1.Fix config.sh
	If host pc have 1 interface ，use switch..
	HOST PC===[switch]===wan-DUT
	                  ===lan-DUT
			          ===Internet
	ats_interface='enp3s0f1' -> host pc connect switch port 1 interface
	lan_interface='enp3s0f1' -> host pc connect switch port 1 interface
	wan_interface='enp3s0f1' -> host pc connect switch port 1 interface
	lan_vlan_id='20' -> lan side vlan id 
	wan_vlan_id='30' -> wan side vlan id 
	backup_vlan_id='99'	-> backup vlan id 
	
	If host pc have 3 interface ，no switch can setup it..
	HOST PC===wna-DUT
		   ===lan-DUT
		   ===Internet
		ats_interface='enp3s0' -> connect to internet
		lan_interface='enp4s0' -> connect to lan
		wan_interface='enp5s0' -> connect to wan
		lan_vlan_id='20' -> not be use
		wan_vlan_id='30' -> not be use
		backup_vlan_id='99'	-> backup vlan id (use ats_interface)

2.Setup interface 
	execute 
	# ./remove_vlan_interface.sh
	execute
	# ./interface_vlan_set.sh
	execute
	# ./start_env.sh
	=> if first execute will create docker image.

3.Test script create at
	./ATS_CI/ATS_docker/docker_ats/tests/
	
4.Execute test script
	cat /ATS_CI/ATS_docker/robot_test/execute_test.sh
	# docker exec -w /workspace/tests/White_label_ATS-WREQ-130BE env-ats sh ./test.sh
	/workspace/tests/White_label_ATS-WREQ-130BE => is docker path
	./test.sh => test case script
	
5.Test report 
	./ATS_CI/ATS_docker/docker_ats/tests/White_label_ATS-WREQ-130BE/report/  => test.sh define
	
-----------------------------------------------------------------------------------------------------------
test step

1. Setup host pc 
2. ./remove_vlan_interface.sh ==> del interface vlan info
3. ./interface_vlan_set.sh ==> add interface vlan info
4. ./start_env.sh ==> create docker image
5. ./robot_test/execute_test.sh ==> execute test script






