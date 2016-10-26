<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   importjson.php
   
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
<div class="importjson-popup" data-dismissible="false"  data-role="popup">
    <div data-role="header">
	<h1>Import JSON</h1>
    </div>
    <div data-role="main"  class="ui-content">
	<p>Paste the JSON string here</p>
	<textarea cols="40" class="ui-body" id="importjson_input"></textarea>
	<a id="importjson_importbtn" data-mini="true" class="ui-btn ui-corner-all">Import</a>
    </div>
</div>
