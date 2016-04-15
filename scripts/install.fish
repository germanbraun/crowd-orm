#! /usr/bin/fish


# Copyright 2016 Giménez, Christian

# Author: Giménez, Christian   

# install.fish

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set requirements "npm" "nodejs" "coffee"
set optional "phpunit" "Executes PHP tests" "doxygen" "Compiles PHP documentation" "doxywizard" "Configure Doxygen documentation compiler"

function status --description 'Display a status messages on the terminal.'
	set_color cyan
	echo $argv[1]
	set_color normal
end

function error --description 'Show an error message.'
	set_color red
	echo 'Error:' $argv[1]
	set_color normal
end

function show-icon --description "Show the UTF-8 icon properly"
	set_color --bold
	echo -n "$argv[1] "
	set_color normal
end

function create-tempfiles --description 'Create and initialize temporary files.'
	status "Creating temporary file"
	echo "" > run/input-file.owllink
	status "Setting Permissions"
	chmod a+rwx run
	chmod a+rwx run/input-file.owllink
end

function install-config --description 'Install the configuration parameters.'
	status "Installing configuration"
	cp web-src/config/config.php.example web-src/config/config.php
	status "Please, edit the configuration parameters"
	xdg-open web-src/config/config.php
end

function show-help --description 'Show a helpful text for the user.'
	echo '
./install.fish
	
Install the CROWD. Will create and check for necessary files and permissions. 
'
end

function check-requirements --description 'Check for the existence of some programs'
	status "Checking for required software..."
	set problem 0
		
	for req in $requirements
		if which $req > /dev/null
			show-icon "✓"
			echo "$req founded."
		else
			set problem 1
			show-icon "❌"
			error "$req is not founded! Please install it."
		end
	end
	
	status "Checking for optional software..."
	echo "This software is not needed for running CROWD, but you'll need it if you want to develop."
	set desc 0
	for opt in $optional
		if test $desc -eq 1
			set desc 0
			echo "    Description: " $opt
		else
			# Current index is not a description
			set desc 1
			if which $opt > /dev/null
				show-icon "☺"
				echo "$opt founded."
			else
				show-icon "☹"
				echo "$opt not founded!"
			end
		end
	end
end

if test ! -z "$argv[1]"
	show-help
	exit
end

check-requirements

create-tempfiles

install-config

status "Compiling CoffeeScripts into Javascript..."
scripts/compilar-coffee.sh
