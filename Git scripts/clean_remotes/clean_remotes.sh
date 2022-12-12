#!/bin/bash

# Perform actual cleaning
cleanbrokenremotes() {
	# 'git branch -vv' displays "gone" for local branches whose remote has been pruned
	git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs -p git branch -D
}

# Just as a safety measure, we ask the user to confirm they are on their main branch
changemasterbranch() {
	echo "Are you on your 'main' branch? (Usually 'master' or 'develop')?"
	echo "(Select answer with numerical input)"
select yn in "Yes" "No"; do
    case $yn in
        Yes )  cleanbrokenremotes; echo -e "\n Done."; break;;
        No )  echo -e "To avoid mishandling of branches, this will not continue!\nRerun command after changing branch."; exit;;
    esac
done
}

# Start from the safety check
changemasterbranch $@
