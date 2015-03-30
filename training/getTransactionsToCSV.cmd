#
# sed command file (# are comment lines)
#
# append the line 'After Brenda'
# in this customer file
#
#Save this script file as sed1.cmd. Then, to run sed using this script file, use this syntax:
#
#
#sed -f sed1.cmd customer.txt
#
s/ Reinvestment /\tReinvestment\t/g

