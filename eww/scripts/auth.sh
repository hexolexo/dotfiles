#!/bin/bash
# SOURCE: https://stackoverflow.com/questions/1459682/check-unix-username-and-password-in-a-shellscript/1503831#1503831
if [ ! $# -eq 1 ]; then
        echo "Wrong Number of Arguments (expected 1, got $#)" 1>&2
        exit 1
fi

USERNAME=$(whoami)
PASSWORD=$1

export LC_ALL=C
expect << EOF
spawn su $USERNAME -c "exit" 
expect "Password:"
send "$PASSWORD\r"

set wait_result  [wait]

# check if it is an OS error or a return code from our command
#   index 2 should be -1 for OS erro, 0 for command return code
if {[lindex \$wait_result 2] == 0} {
        exit [lindex \$wait_result 3]
} 
else {
        exit 1 
}
EOF
