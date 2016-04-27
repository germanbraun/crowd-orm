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

echo "Executing codo, ensure you're at the root of the project directory."
codo -o docs/coffee/ web-src/coffee tests/js/coffee
