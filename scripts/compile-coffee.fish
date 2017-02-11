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

set_color --bold white
echo "Compiling Coffeescripts into Javascript"
set_color normal
coffee --output web-src/js/ --compile web-src/coffee/

set model_order diagram umldiagram factories mymodel products server_connection

set_color --bold white
echo "Mergin model files"
set_color normal
if test -f web-src/js/model.js
	rm -v web-src/js/model.js
end
for js in $model_order
	echo "Merging web_src/js/$js.js into web-src/js/model.js"
	cat web-src/js/model/$js.js  >> web-src/js/model.js
	rm -v web-src/js/model/$js.js
end

set_color --bold white
echo "Mergin backbone_views files"
set_color normal
if test -f web-src/js/backbone_views.js
	rm -v web-src/js/backbone_views.js
end
for js in web-src/js/views/*.js
	echo "Merging $js into web-src/js/backbone_views.js"
	cat $js >> web-src/js/backbone_views.js
	rm -v $js
end

# Compile tests coffee scripts

coffee --output tests/js/js --compile tests/js/coffee
