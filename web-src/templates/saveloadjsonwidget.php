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
<div id="saveloadjsonwidget" class="saveloadjsonwidget">
    <div data-role="collapsible" data-collapsed="true"
	 data-collapsed-icon="carat-d" data-expanded-icon="carat-u">
	<h1 id="savejson-header">Save</h1>
	<form id="savejson-form">
	    <label>Model name</label>
	    <input type="text" id="savejson_name" data-mini="true" />
	    <a class="ui-btn ui-corner-all ui-icon-check" type="button" id="savejson_save_btn">Save</a>
	</form>
    </div>

    <div data-role="collapsible" data-collapsed="true"
	 data-collapsed-icon="carat-d" data-expanded-icon="carat-u">
	<h1 id="loadjson-header">Load</h1>
	<form id="loadjson-form">
	    <ul data-role="listview" id="modelList" data-inset="true"
		data-autodividers="true" data-filter="true" data-filter-placeholder="Model...">
	    </ul>
	</form>
    </div>
</div>
