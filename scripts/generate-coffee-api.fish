#! /usr/bin/fish


# Copyright 2016 Giménez, Christian

# Author: Giménez, Christian   

# generate-coffee-api.fish

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

set_color normal
echo "Ensure you're at the root of the project directory."
echo "Use `scripts/generate-coffee-api.fish t` for running docco too."
echo
set_color --bold white
echo "Executing codo"
set_color normal
codo -v -o docs/coffee/ web-src/coffee tests/js/coffee

if test -z "$argv[1]"
	set_color --bold white
	echo "Skipping docco."
	set_color normal
else
	if which docco ^ /dev/null > /dev/null
		set_color --bold white
		echo "Executing docco."
		set_color normal		
		docco (find web-src/coffee) -o docs/docco		
	else
		set_color --bold white
		echo "Docco not founded."
		set_color normal
	end
end
