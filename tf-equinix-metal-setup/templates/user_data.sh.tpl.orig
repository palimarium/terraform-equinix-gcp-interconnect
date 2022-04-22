#!/bin/bash
yum update -y
yum install epel-release -y
yum install bird jq -y
yum install vlan -y
cat <<\EOF >> /etc/sysconfig/network-scripts/ifcfg-bond0.${METAL_VXLAN}
DEVICE=bond0.${METAL_VXLAN}
NAME=bond0.${METAL_VXLAN}
IPADDR=172.16.0.${LAST_OCTET}
NETMASK=255.255.255.0
GATEWAY=172.16.0.1
VLAN=yes
BOOTPROTO=none
ONBOOT=yes
USERCTL=no
TYPE=Bond
BONDING_OPTS="mode=4 miimon=100 downdelay=200 updelay=200"
EOF
service network restart
