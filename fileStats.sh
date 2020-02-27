#!/bin/bash

#Z9.0
function charStat() {
	if [ -e $1 ]; then
		if [ ! -r $1 ]; then
			echo "Nie masz praw odczytu do pliku zrodlowego!"
			exit -1
		fi
	else
		echo "Plik zrodlowy nie istnieje!"
		exit -1
	fi

	if [ -e $2 ]; then
		if [ ! -w $2 ]; then
			echo "Nie masz praw zapisu do pliku docelowego!"
			exit -1
		fi
	else
		if touch $2; then
			touch $2
		else
			echo "Nie mozna utworzyc pliku docelowego!"
			exit -1
		fi
	fi

	alphabet=(a b c d e f g h i j k l m n o p q r s t u v w x y z)

	declare -A stats

	for letter in ${alphabet[*]}; do
		regex="[$letter]"
		cnt=$(grep -io $regex $1 | wc -l)
		stats[$letter]=$cnt
		echo "$letter "$cnt >> $2
	done

	sort -rn -k2 $2 >> $2
	sed -i "1,26d" $2
}

charStat "$@"