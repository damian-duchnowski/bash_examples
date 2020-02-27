#!/bin/bash

#Z7.0
tablica=("$@") # wiem, ze miala byc w funkcji, ale wtedy nie moglbym zaimplementowac wyswietlenia przed i po

function insertSort() {
	i=0
	key=0
	j=0

	for (( i = 1; i < ${#tablica[@]}; i++ )); do
		key=${tablica[$i]}
		j=$(( $i - 1 ))

		while [ "$j" -ge 0 ] && [ $(echo "${tablica[$j]}>$key" | bc) -eq 1 ]; do
			tablica[$j+1]=${tablica[$j]}
			j=$(( $j - 1 ))
		done

		tablica[$j+1]=$key
	done
}

echo "#Z7.0"
echo "====="
echo "Podana tablica: ${tablica[*]}"
insertSort "$@"
echo "Posortowana: ${tablica[*]}"

#Z7.1
function twoDimArr() {
	declare -A arr

	if [[ $1 =~ ^-?[0-9]+$ ]] && [[ $2 =~ ^-?[0-9]+$ ]]; then
		for (( i = 0; i < $1; i++ )); do
			for (( j = 0; j < $2; j++ )); do
				arr[$i,$j]=$((RANDOM % 21))
			done
		done

		for (( i = 0; i < $1; i++ )); do
			for (( j = 0; j < $2; j++ )); do
				if [ "${arr[$i,$j]}" -lt 10 ]; then
					echo -n " ${arr[$i,$j]} "
				else
					echo -n "${arr[$i,$j]} "
				fi
			done
			echo
		done
	else
		echo "ERROR: incorrect arguments!"
		exit 1
	fi
}

echo
echo "#Z7.1"
echo "===="
twoDimArr $1 $2