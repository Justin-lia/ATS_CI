function_name="113be"
#robot -i mesh_mlo_test --output report/mesh/output_mesh.xml --log report/mesh/log_mesh.html --report report/mesh/report_mesh.html test_suites/Mesh/01-WIFI7_MLO.robot
robot -t "Other test enable sshd" --output report/mesh/output_mesh.xml --log report/mesh/log_mesh.html --report report/mesh/report_mesh.html test_suites/tmp/other_test.robot