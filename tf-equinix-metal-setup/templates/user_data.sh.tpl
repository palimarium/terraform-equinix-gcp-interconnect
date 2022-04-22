#!/bin/bash
yum update -y
yum install epel-release -y
yum install bird jq -y
yum install vlan -y
cat <<\EOF >> /etc/sysconfig/network-scripts/ifcfg-bond0.${METAL_VXLAN}
DEVICE=bond0.${METAL_VXLAN}
NAME=bond0.${METAL_VXLAN}
IPADDR=172.16.0.100
NETMASK=255.255.255.0
GATEWAY=172.16.0.1
VLAN=yes
BOOTPROTO=none
ONBOOT=yes
USERCTL=no
TYPE=Bond
BONDING_OPTS="mode=4 miimon=100 downdelay=200 updelay=200"
EOF

// create static route to GCP
cat <<\EOF >> /etc/sysconfig/network-scripts/route-bond0.${METAL_VXLAN}
10.240.0.0/24 via 172.16.0.50 dev bond0.1000
EOF

systemctl restart network
