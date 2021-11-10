#!/bin/bash

# Credits:
#	Simone Vollaro (slim71sv@gmail.it)

###############################################################################
# Error handling
# TODO: better handling of errors?

# Exit immediately if a command exits with a non-zero status.
set -e

###############################################################################
# Flags

# To set internal debug mode
DEBUG_FLAG=0

INST_FLAG=0
LIST_FLAG=0

###############################################################################
# Defines

BASE_FOLDER=$(pwd)
AUX_FOLDER=temp

INPUT_LIST=()

INDEX=0
###############################################################################
# Useful functions

# Help function
Usage()
{
	# Displaying help...
	echo "Available options:"
	echo
	echo "--[...] -[...]"
	echo "    Does something."
	echo "    Longer description here."
	echo
	echo "--help -h"
	echo "    Display this help."
}

# Custom print for debug purposes
cecho()
{
	if [[ $DEBUG_FLAG -eq 1 ]]; then
		printf '%s \n' "$*"
	fi
}

# Note: This script was part of a build mechanism
# To use colormake if available (executed in silent mode)
comake()
{	
	cecho "$@"
	
	if ! command -v colormake &> /dev/null
	then
		cecho "colormake could not be found" && cecho
		make -s "$@"
	else
		colormake -s "$@"
	fi
	cecho
}

error_handler()
{
	cecho "Program interrupted. Cleaning up..."
	
	# Cleanup actions here
	
	cecho "Done."
}

###############################################################################
# Parse arguments and find options

# Priority: debug mode to be activated?
for argument in "$@"; do
	((INDEX=INDEX+1))
	
	case $argument in
		-d|--debug)
			# Activate internal debug mode
			DEBUG_FLAG=1
			cecho "Debug mode enabled." && cecho
			break 1
			;;
		*)
			# Other arguments
			cecho "Something else: $argument"
	esac
	
	if [[ $INDEX -ge $# ]] ; then
		break
	fi
done

# Drop the '-d' (if found) and keep other arguments
if [[ "$INDEX" -gt 0 ]] ; then
	set -- "${@:1:INDEX-1}" "${@:INDEX+1}"
fi

# Debug
cecho "Arguments remaining (excluding -d): $@" && cecho

# Handle long-option (--option) and short-option (-opt) as well as 
# non-option (<argument>) arguments

# TODO: migrate to getopts?
args=$(getopt -l "debug,name:,install,help,list:" -o "n:ihdl:" -- "$@")

# Debug
cecho "Arguments: $args" && cecho

# TODO: remove eval but evaluate arguments?
# Variables in the arguments will be evaluated
eval set -- "${args[@]}"

while [ $# -ge 1 ]; do
	cecho "Argument to be processed: $1"
	case "$1" in
		--) 
			# No more options left, or other argument to insert in list
			cecho "Remaining args: $@"
			for argument in "$@"; do
				if [[ $1 == -- ]]; then # Space or no more arguments
					cecho "Void parameter (--)"
					shift # drop the --
				else # Another module to append in list
					cecho "Something else specified: $1"
					if [[ "${1: -1}" == / ]]; then 
						WHAT=${1%?}
						cecho "What is this? $WHAT"
						INPUT_LIST+=("$WHAT")
					else
						INPUT_LIST+=("$1")
					fi
					shift
				fi
			done
			#shift
			break 1
			;;
			
		-n|--name) # Note: This script was initially used to build an archive
			# Name to use for archive and notes
			ARCHIVE_NAME="$2"
			cecho "Archive name: $ARCHIVE_NAME"
			shift 2
			;;
			
		-i|--install) # Note: This script included some adb operations
			# Install directly on target
			INST_FLAG=1
			cecho "'Install' flag: $INST_FLAG"
			shift
			;;
			
		-l|--list)
			# Specify element list
			LIST_FLAG=1
			cecho "Number of subsequent arguments: $#"
			shift # drop the -l
			for arg in "$@"; do
				cecho "Argument in for loop: $1"
				if [[ $1 == -* ]]; then # other option or void argument
					cecho "Different option -> skip ahead"
					break 1
				else # first element to append in list
					cecho "Element to insert in list: $1"
					if [[ "${1: -1}" == / ]]; then 
						WHAT=${1%?}
						cecho "What element? $WHAT"
						INPUT_LIST+=("$WHAT")
					else
						INPUT_LIST+=("$1")
					fi
					shift
				fi
			done
			;;
			
		-h|--help)
			Usage
			exit 0
			;;
		*)
			# Handle some other input
			# Not needed, since getopt filters out provided arguments
			cecho "Some other stuff: $1"
			Usage
			exit 0
	esac
	cecho
done

# Debug
cecho && cecho "Printing INPUT_LIST..."
for value in "${INPUT_LIST[@]}" ; do
	cecho "$value" 
done
cecho "Done." && cecho

###############################################################################
# ............................Some other stuff.................................
###############################################################################

trap - EXIT