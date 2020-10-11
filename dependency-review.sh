#!/bin/bash

echo "OWASP Dependency Checker Started..."

checkerpath=$1
reportpath=$2
severity=$3

critical=`echo $severity | cut -d '}' -f1 | cut -d ',' -f2`
high=`echo $severity | cut -d '}' -f2 | cut -d ',' -f3`
medium=`echo $severity | cut -d '}' -f3 | cut -d ',' -f3`
low=`echo $severity | cut -d '}' -f4 | cut -d ',' -f3`

critresult=`python $checkerpath $reportpath CRITICAL`
highresult=`python $checkerpath $reportpath HIGH`
medresult=`python $checkerpath $reportpath MEDIUM`
lowresult=`python $checkerpath $reportpath LOW`

totalcount=`echo $critresult | cut -d ' ' -f2`
critcount=`echo $critresult | cut -d ' ' -f1`
highcount=`echo $highresult | cut -d ' ' -f1`
medcount=`echo $medresult | cut -d ' ' -f1`
lowcount=`echo $lowresult | cut -d ' ' -f1`

f=1
if [ "$critcount" -gt "$critical" ]
then
	f=0
	echo "Number Of CRITICAL Issues Identified Are More Than Allowed Threshold !"
else
	if [ "$highcount" -gt "$high" ]
	then
		f=0
		echo "Number Of HIGH Issues Identified Are More Than Allowed Threshold !" 
	else
		if [ "$medcount" -gt "$medium" ]
		then
			f=0
			echo "Number Of MEDIUM Issues Identified Are More Than Allowed Threshold !"
		else
			if [ "$lowcount" -gt "$low" ]
			then
				f=0
				echo "Number Of LOW Issues Identified Are More Than Allowed Threshold !"
			fi
		fi
	fi
fi

echo
echo "Scanning Completed !"
echo "Total Vulnerabilities : $totalcount"
echo "CRITICAL : $critcount"
echo "HIGH : $highcount"
echo "MEDIUM : $medcount"
echo "LOW : $lowcount"
echo
if [ "$f" == 1 ]
then
	echo "Result : PASSED !!"
	echo "Continuing Pipeline Process..."
else
	echo "Result : FAILED !!"
	exit 100
fi
