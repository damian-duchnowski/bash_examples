#!/bin/bash

#Z1
mkdir $2

#Z2
find $1 -type f -iname '*.csv'

#Z3
find $1 -type d -name '[ABc]*'

#Z4
find $1 -type f -executable -readable

#Z5
find $1 -type f -empty

#Z6
find $1 -type l

#Z7
find $1 -type f -group users -size +100k -name '*.txt' -o -name '*.csv'

#Z8
find $1 -type f -perm /u=s -o -perm /g=s

#Z9
find $1 -type d -perm +1000

#Z10
find $1 -type f -mtime 1

#Z11
find /dev/ -type b

#Z12
find $1 -type d -o -type f -empty -exec rm -fr {} \;

#Z13
find $1 -type f -executable -name '*.sh' -exec mv {} $2 \;

#Z14
find $1 -type d -readable -exec cp -r {} $2 \;