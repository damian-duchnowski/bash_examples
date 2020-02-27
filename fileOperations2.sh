#!/bin/bash

#Z10.0
function biggestFiles() {
	if [ $# != 2 ]; then
		echo "Niepoprawna liczba argumentow!"
		exit -1
	fi

	if [ ! -d $1 ]; then
		echo "Podany argument nie jest katalogiem!"
		exit -1
	fi

	if [ ! -r $1 ]; then
		echo "Nie masz praw odczytu do katalogu zrodlowego"
		exit -1
	fi

	if [ ! -e $2 ]; then
		touch $2
	else
		if [ ! -w $2 ]; then
			echo "Nie masz praw zapisu do pliku wynikowego!"
			exit -1
		fi
	fi

	find $1 -type f -printf '%s %p\n' | sort -nr | head -n3 > $2
}

#Z10.1
function findType() {
	if [ $# != 3 ]; then
		echo "Nieprawidlowa liczba argumentow!"
		exit -1
	fi

	if [[ ! $2 =~ ^[A-Za-z0-9]+$ ]]; then
		echo "Zly format rozszerzenia, podaj w postaci bez kropki!"
		exit -1
	fi

	if [ ! -e $1 ]; then
		echo "Katalog zrodlowy nie istnieje!"
		exit -1
	fi

	if [ ! -d $1 ]; then
		echo "arg1 nie jest katalogiem!"
		exit -1
	fi

	if [ ! -r $1 ]; then
		echo "Nie masz praw odczytu do katalogu zrodlowego!"
		exit -1
	fi

	if [ ! -e $3 ]; then
		mkdir $3
	fi

	if [ ! -d $3 ]; then
		echo "arg3 nie jest katalogiem!"
		exit -1
	fi

	if [ ! -w $3 ]; then
		echo "Nie masz praw zapisu do katalogu z kopiami!"
		exit -1
	fi

	for file in $(find $1 -type f -printf '%p\n' | grep -iE "\."$2"+$"); do
		cp "$file" $3
		mv $3/$(basename "$file") $3/$(basename "$file" | cut -f1 -d ".").COPY
	done
}

#Z10.2
function findFilesWithHardlinks() {
	if [ $# != 2 ]; then
		echo "Nieprawidlowa liczba argumentow!"
		exit -1
	fi

	if [ ! -e $1]; then
		mkdir $1
	fi

	if [ ! -d $1 ]; then
		echo "arg1 nie jest katalogiem!"
		exit -1
	fi

	if [ ! -r $1 ]; then
		echo "Nie masz praw odczytu do katalogu zrodlowego!"
		exit -1
	fi

	if [ ! -e $2 ]; then
		touch $2
	fi

	if [ ! -w $2 ]; then
		echo "Nie masz praw zapisu do pliku wynikowego!"
		exit -1
	fi

	ls -R $1 | grep -E "^\-" > temp

	while read line; do
		find $1 -samefile $line | head -n1 >> $2
	done <./temp

	rm ./temp
}

#biggestFiles "$@"
findType "$@"
#findFilesWithHardlinks "$@"
