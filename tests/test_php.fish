#! /usr/bin/fish


# Copyright 2016 Giménez, Christian

# Author: Giménez, Christian   

# test_php.fish

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

cd php

function execute_test
	echo "----------------------------------------------------------------------------------------------------"
	set_color -o  ;	echo $argv[1]
	set_color normal
	rm ../temp/*.owllink
	phpunit --colors=always --include ../../web-src $argv[1]
end

if test -z "$argv[1]" 
	for testfile in (find -name '*.php')
		execute_test $testfile
	end
else
	set testfile (find -name  "$argv[1]test.php")
	if test ! -z "$testfile"
		execute_test $testfile
	end
end
