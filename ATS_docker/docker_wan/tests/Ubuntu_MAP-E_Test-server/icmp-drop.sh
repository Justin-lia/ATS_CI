#!/bin/bash

iptables -A OUTPUT -p icmp --icmp-type any -j DROP
