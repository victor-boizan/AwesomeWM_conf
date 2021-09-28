#!/bin/sh

# This scrips is made to output the number of packages to update on the system.

function_Gentoo_Linux () {
	NB=$(emerge -pv --update --changed-use --deep @world | awk '{if ($1 == "Total:"){print $2}}')
	echo $NB
}

#Extract the distribution name with a python programe named distro. then it 
#call a function named "function_<name of the distro>" by concting the name 
#of the distro with the string "function_"
DISTRO=$(distro | awk '{if ($1 == "Name:"){print $2}}' | tr '/' '_')
function_$DISTRO

