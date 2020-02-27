#!/bin/bash

#Z6.0
foo () {
	licznik=$(($1 - $2))
	mianownik=$(($1 + $2))

	if [ $mianownik -eq 0 ]; then
		echo 'ERROR: mianownik nie moze byc rowny 0!'
		exit -1
	fi

	wynik=$((licznik / mianownik))

	echo $wynik
}

#Z6.1
fiboSeqRec() {
	if [ $# != 1 ]; then
		echo 'ERROR: dozwolony tylko 1 argument!'
		exit -1
	fi

	if [ $1 -lt 0 ]; then
		echo 'ERROR: niedozwolony argument!'
		exit -1
	elif [ $1 -le 1 ]; then echo 1
	else
		echo $(($(fiboSeqRec $(($1 - 1))) + $(fiboSeqRec $(($1 - 2)))))
	fi
}

#Z6.2
fiboSeqIt () {
	if [ $# != 1 ]; then
		echo 'ERROR: dozwolony tylko 1 argument!'
		exit -1
	fi

	if [ $1 -le 0 ]; then
		echo 'ERROR: niedozwolony argument!'
		exit -2
	fi

	arr=(0 1)

	for (( i = 0; i < $1; i++ )); do
		if [ $i -lt 2 ]; then echo ${arr[$i]}
		else
			arr[$i]=$(( ${arr[$i - 1]} + ${arr[$i - 2]}))
			echo ${arr[i]}
		fi
	done
}

max () {
	local max=0

	for number in $@; do
		if [ $(echo "$number > $max" | bc) -eq 1 ]; then max=$number; fi
	done

	echo $max
}

echo '#Z6.0'
echo '====='
foo $1 $2

echo
echo '#Z6.1'
echo '====='
fiboSeqRec $1

echo
echo '#Z6.2'
echo '====='
fiboSeqIt $1

echo
echo '#Z6.3'
echo '====='
max $@