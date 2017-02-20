#!/bin/bash
# Run in the main project directory to find all unused i18n messages listed in files whose name is 'messages.properties'.

files=`find . -name 'messages.properties' 2> /dev/null | grep -v 'target/classes/'`

echo "$files" | while read file
do
	if [ -n "$file" ];
	then
	cat "$file" |
		while read line
		do
			var1=$(echo $line | cut -f1 -d=)
			if [ -n "$var1" ];
			then
				v=`grep -r $var1 2> /dev/null | grep -v -E 'messages.properties|Messages.java|/target/classes/|/bin/src/'`
				if [ -z "$v" ]; then
					echo "$file: $var1 doesn't exist anywhere"
				fi
			fi
		done
	fi
done

