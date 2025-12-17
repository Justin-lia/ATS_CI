*** Settings ***
Library           Collections
Library           DateTime
Library           String
Library           OperatingSystem
Library           SeleniumLibrary
Resource          keyword/Variable.robot
Resource          keyword/telnet_ssh_sample.robot
Variables         ./config/topology/Myvariable.yaml
Library           ./library/pytestlink.py
Library           ./library/pyserial.py


