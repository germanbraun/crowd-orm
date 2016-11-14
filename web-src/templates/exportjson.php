<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   exportjson.php
   
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
<p>Copy this text for importing again in a new session.</p>
<p>Use the Refresh button to refresh the JSON content with the last modifications.</p>
<textarea cols="40" class="ui-body" id="exportjson_input"><%= jsonstr %></textarea>
<div data-role="controlgroup" data-mini="true" data-type="horizontal">
    <a id="exportjson_copybtn" data-mini="true" class="ui-btn ui-corner-all">Copy</a>
    <a id="exportjson_refreshbtn" data-mini="true" class="ui-btn ui-corner-all">Refresh</a>
</div>
