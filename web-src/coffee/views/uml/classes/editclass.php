<?php
/*

   Copyright 2016 Giménez, Christian

   Author: Giménez, Christian

   editclass.php

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


?>
<form>
    <input type="hidden" id="editclass_classid" name="classid" value="<%= classid %>" />
    <input data-mini="true" placeholder="ClassName" type="text" id="editclass_input"  />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal">
	<a class="ui-btn ui-corner-all ui-icon-check ui-btn-icon-notext" type="button" id="uml_editclass_button">Accept</a>
	<a class="ui-btn ui-corner-all ui-icon-back ui-btn-icon-notext" type="button" id="uml_close_button">Close</a>
    </div>
</form>
