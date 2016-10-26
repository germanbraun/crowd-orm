#! /usr/bin/fish

 
# Copyright 2016 Giménez, Christian

# Author: Giménez, Christian   

# compilar-coffee.fish

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

#######################################################################
#
# Uso: scripts/compilar-coffee.sh
#

echo "Compiling Coffeescripts into Javascript"
coffee --output web-src/js --compile web-src/coffee
set model_order diagram factories mymodel products server_connection

echo "Mergin model files"
if test -f web-src/js/model.js
	rm web-src/js/model.js
end
for js in $model_order
	cat web-src/js/model/$js.js  >> web-src/js/model.js
	rm web-src/js/model/$js.js
end

# Compile tests coffee scripts

coffee --output tests/js/js --compile tests/js/coffee
