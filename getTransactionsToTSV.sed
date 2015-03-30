#
# sed command file (# are comment lines)
#
# append the line 'After Brenda'
# in this customer file
#
#Save this script file as sed1.cmd. Then, to run sed using this script file, use this syntax:
#
#
#sed -f <THIS-FILE>.sed customer.txt
#

s/^ //
s/ Reinvestment/\tReinvestment/g
s/ ([[:digit:]]+)/\t\1/gp

