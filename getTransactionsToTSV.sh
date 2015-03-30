#!/bin/bash
# Driver script to extract transactions
#
# Example format:
# 1/31 DIVIDEND RECEIVED 10.83
# 1/31 Reinvestment 0.951 11.39 10.83
# 2/28 DIVIDEND RECEIVED 8.84
# 2/28 Reinvestment 0.781 11.32 8.84
# 3/31 DIVIDEND RECEIVED 8.58
# 3/31 Reinvestment 0.758 11.32 8.58
# 4/29 DIVIDEND RECEIVED 9.12
# 4/29 Reinvestment 0.792 11.51 9.12

cat ~/bin/examples/transactions.txt | grep -F -e 'Reinvestment' | sed -rnf getTransactionsToTSV.sed