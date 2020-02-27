#!/bin/bash

#Z8.0
function splitLines() {
	if [ $# != 3 ]; then
		echo "Nieprawidlowa liczba argumentow!"
		exit 1
	fi

	if [ ! -r $1 ]; then
		echo "Nie masz praw do odczytania tego pliku!"
		exit -1
	fi

	if [ ! -e $2 ] || [ ! -e $3 ]; then
		touch $2 $3
	fi

	if [ -e $2 ] && [ -e $3 ]; then
		if [ ! -r $2 ] || [ ! -r $3 ]; then
			echo "Nie masz praw zapisu dla podanych plikow!"
			exit -1
		fi

		> $2
		> $3
	fi

	cnt=1
	while read line; do
		if [ $(( $cnt % 2 )) -eq 0 ]; then
			echo "#$cnt: "$line >> $2
		else
			echo "#$cnt: "$line >> $3
		fi
		((cnt++))
	done <$1
}

#Z8.1
function createDirTree() {
	if [ ! -d $1 ]; then
		echo "Sciezka nie wskazuje na katalog!" >&2
		exit -1
	fi

	if [ ! -w $1 ]; then
		echo "Nie masz praw zapisu w tym katalogu!" >&2
		exit -1
	fi

	if [ ! -r $2 ]; then
		echo "Nie masz praw odczytu do tego pliku!" >&2
		exit -1
	fi

	while read line; do
		if [[ $line = D* ]]; then
			mkdir -p $line
		elif [[ $line = F* ]]; then
			dir=$( echo $line | echo $(grep -oP "[^F]([A-Za-z0-9]+\/)+") )
			file=$( echo $line | echo $(grep -oP "[^F]([A-Za-z0-9]+\/)+[A-Za-z0-9].*") )
			if [ -e $file ]; then
				continue
			else
				if [ ! -e $dir ]; then
					$dir | xargs mkdir -p
					touch $file
				else
					touch $file
				fi
			fi
		else
			continue
		fi
	done <$2
}

splitLines "$@"
createDirTree "$@"