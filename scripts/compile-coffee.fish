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

function compile_common --description="Compiles common files"
	set_color --bold white
	echo "Compiling CoffeeScripts into Javascript"
	set_color normal
	coffee --output web-src/js/ --compile web-src/coffee/
end

function merge_model --description="Compiles the model CoffeeScripts."
	# set model_order diagram factories uml/umlfactory uml/umldiagram eerdiagram mymodel products server_connection uml/class uml/generalization uml/link uml/link_with_class
	set model_order diagram factories uml/umlfactory uml/umldiagram uml/umlimporter mymodel server_connection uml/class uml/link uml/generalization uml/link_with_class eer/eerfactory eer/eerdiagram eer/entity eer/attribute eer/isa eer/linkattrtoentity eer/linkisatoentity

	set_color --bold white
	echo "Merging model files"
	set_color normal

	echo "Removing previous output"
	if test -f web-src/js/model.js
		rm -v web-src/js/model.js
	end

	echo "Merging."
	for js in $model_order
		echo "Merging web_src/js/$js.js into web-src/js/model.js"
		cat web-src/js/model/$js.js  >> web-src/js/model.js
		rm -v web-src/js/model/$js.js
	end

	set_color red
	echo "Files compiled but not merged:"
	set_color white
	ls web-src/js/model/
end

function compile_model --description="Compiles the model files only and merge it"
	set_color --bold white
	echo "Compiling Models files into JS"
	set_color normal
	coffee --output web-src/js/model --compile web-src/coffee/model
	merge_model
end

function merge_views --description="Compiles backbone views scripts"
	set_color --bold white
	echo "Merging backbone_views files"
	set_color normal

	echo "Removing previous output"
	if test -f web-src/js/backbone_views.js
		rm -v web-src/js/backbone_views.js
	end

	echo "Merging"
	for js in web-src/js/views/*.js
		echo "Merging $js into web-src/js/backbone_views.js"
		cat $js >> web-src/js/backbone_views.js
		rm -v $js
	end

  for js in web-src/js/views/eer/*.js
    echo "Merging $js into web-src/js/backbone_views.js"
    cat $js >> web-src/js/backbone_views.js
    rm -v $js
  end

  for js in web-src/js/views/common/*.js
    echo "Merging $js into web-src/js/backbone_views.js"
    cat $js >> web-src/js/backbone_views.js
    rm -v $js
  end

	set_color red
	echo "Files compiled but not merged:"
	set_color white
	ls web-src/js/views/
end

function compile_views --description="Compile only the backbone's views and merge them"
	set_color --bold white
	echo "Compiling Backbone's views files into JS"
	set_color normal
	coffee --output web-src/js/views --compile web-src/coffee/views
	merge_views
end


function compile_tests --description="Compile tests scripts"
	# Compile tests coffee scripts
	set_color --bold white
	echo "Compiling tests"
	set_color normal
	coffee --output tests/js/js --compile tests/js/coffee
end

function compile_gui --description="Compile the GUI namespace"
	set_color --bold white
	echo "Compiling GUI"
	set_color normal
	coffee --output web-src/js/gui --compile web-src/coffee/gui
	merge_gui
end

function merge_gui --description="Compiles GUI scripts"

	set order gui guiimpl guiuml guieer GUIState associationstate isastate selectionstate

	set_color --bold white
	echo "Merging GUI files"
	set_color normal

	echo "Removing previous output"
	if test -f web-src/js/gui.js
		rm -v web-src/js/gui.js
	end

	echo "Merging"
	for js in $order
		echo "Merging $js into web-src/js/gui.js"
		cat web-src/js/gui/$js.js >> web-src/js/gui.js
		rm -v web-src/js/gui/$js.js
	end

	set_color red
	echo "Files compiled but not merged:"
	set_color white
	ls web-src/js/gui/
end



echo
set_color --bold white
echo "Synopsis:"
set_color normal
echo
set_color green
echo "scripts/compile-coffee.fish WHAT"
set_color normal
echo "    Where WHAT can one of the compile_WHAT functions (read this script file)."
echo "    Compiles only one part of the software."
echo "    Example: scripts/compile-coffee.fish tests"
set_color green
echo "scripts/compile-coffee.fish"
set_color normal
echo "    Compiles all CoffeeScripts."
echo "__________________________________________________"

if test -z "$argv[1]"
	compile_common
	merge_gui
	merge_model
	merge_views
	compile_tests
else
	set -l fnc "compile_$argv[1]"
	eval $fnc
end
