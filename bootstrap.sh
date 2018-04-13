#!/usr/bin/env bash

# The purpose of this script is to create a link between dot file
# of the home directory with file from this directory

function doIt() {
    to_link_with=$(ls -1 . | grep -v -e "bootstrap.sh" -e "LICENSE" -e "README.md")

    for blob in ${to_link_with}; do
        # Create the relative path from the HOME directory to repository blob
        absolute_path=$(readlink -f ${blob})
        relative_path=${absolute_path#${HOME}/}

        # For the 'bin' directory, doesn't prepend the '.'
        if [ ${blob} == "bin" ]; then
            home_blob="${HOME}/${blob}"
        else
            home_blob="${HOME}/.${blob}"
        fi

        # If there is something if the HOME directory, delete it
        # -a file: True if file exists
        if [ -a ${home_blob} ] ; then
            rm -rf ${home_blob}
        fi

        # Create the final symbolic link
        ln -s ${relative_path} ${home_blob}
    done       
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
