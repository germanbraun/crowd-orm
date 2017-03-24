<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   save_load_json.php
   
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
<div id="saveloadjsonwidget" class="saveloadjsonwidget-popup" data-dismissible="false" data-role="popup">
    <div data-role="header" class="saveloadjsonwidget-header">
	<h1 id="savejson-header">Save</h1>
	<h1 id="loadjson-header">Load</h1>
    </div>
    <div data-role="main" class="ui-content login-content">
	<form id="savejson-form">
	    <input type="text" id="savejson_name" data-mini="true" />
	    <a class="ui-btn ui-corner-all ui-icon-check" type="button" id="savejson_save_btn">Save</a>
	</form>
	<form id="loadjson-form">
	    <ul data-role="listview" id="modelList">
	    </ul>
	</form>
	<a class="ui-btn ui-corner-all ui-icon-back" type="button" id="saveloadjson_cancel_btn">Cancel</a>
    </div>
</div>
