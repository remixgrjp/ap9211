#!/bin/bash

TELNET=`which telnet`

if [$TELNET == ""]
then
	echo "telnet is not installed. Please install telnet and try again."
	exit 1
fi

ver=1.0
esc=$'\e'
tab=$'\t'
eol=$'\r'$'\n'

echo "APC AP9211 Device Power Control Script ver${ver}"
if [ $# -le 4 ]; then
  echo "usage : $0 AP9211 user pass device control"
  echo "${tab}ex: $0 192.168.0.1 apc apc 1 2 ( ON device 1 )"
  echo "${tab}device: 1...8"
  echo "${tab}control:"
  echo "${tab}${tab}1- Immediate On"
  echo "${tab}${tab}2- Immediate Off"
  echo "${tab}${tab}3- Immediate Reboot"
  echo "${tab}${tab}4- Delayed On"
  echo "${tab}${tab}5- Delayed Off"
  echo "${tab}${tab}6- Delayed Reboot"
  echo "${tab}${tab}7- Cancel"
  exit 1
fi

if [ $# -ge 1 ]; then
  host=$1
fi
if [ $# -ge 2 ]; then
  user=$2
fi
if [ $# -ge 3 ]; then
  pass=$3
fi
if [ $# -ge 4 ]; then
  ch=$4
fi
if [ $# -ge 5 ]; then
  cmd=$5
fi
echo -e "${host}\n${user} ${pass} ${ch} ${cmd}"

wait=0.5
(
sleep 4;echo "${user}${eol}"
sleep ${wait};echo "${pass}${eol}"
sleep ${wait};echo "1${eol}"
sleep ${wait};echo "${ch}${eol}"
sleep ${wait};echo "1${eol}"
sleep ${wait};echo "${cmd}${eol}"
sleep ${wait};echo "YES${eol}"
sleep ${wait};echo "${esc}"
sleep ${wait};echo "${esc}"
sleep ${wait};echo "${esc}"
sleep ${wait};echo "4${eol}"
sleep 3
) | telnet ${host}

exit 0
