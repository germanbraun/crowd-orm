<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   relationoptions.php
   
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


<div class="relationOptions" style="visible:false, z-index:1, position:absolute">
    <input type="hidden" id="relationoptions_classid"  name="classid"  value="<%= classid %>" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal" style="float: left">
	<form>
    	<input type="hidden" id="relationoptions_classid" name="classid" value="<%= classid %>" />
    	<input data-mini="true" placeholder="0" type="text" id="cardfrom-1" size="2" maxlength="4" />
    	<input type="hidden" id="relationoptions_classid" name="classid" value="<%= classid %>" />
    	<input data-mini="true" placeholder="*" type="text" id="cardfrom-2" size="2" maxlength="4" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal">
	<a class="ui-btn ui-corner-all ui-icon-check ui-btn-icon-notext" type="button" id="cardfrom_accept">Accept</a>
	<a class="ui-btn ui-corner-all ui-icon-back ui-btn-icon-notext" type="button" id="cardfrom_close">Close</a>
    </div>
	</form>
	</div>
	
	<div style="float: left">
	<a class="ui-btn ui-corner-all ui-icon-arrow-r ui-btn-icon-notext" type="button" id="association_button">Association</a>
	</div>
	
	<input type="hidden" id="relationoptions_classid"  name="classid"  value="<%= classid %>" />
	<div data-role="controlgroup" data-mini="true" data-type="horizontal" style="float: right">
	<form>
    	<input type="hidden" id="relationoptions_classid" name="classid" value="<%= classid %>" />
    	<input data-mini="true" placeholder="0" type="text" id="cardto-1" size="2" maxlength="4" />
    	<input type="hidden" id="relationoptions_classid" name="classid" value="<%= classid %>" />
    	<input data-mini="true" placeholder="*" type="text" id="cardto-2" size="2" maxlength="4" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal">
	<a class="ui-btn ui-corner-all ui-icon-check ui-btn-icon-notext" type="button" id="cardto_accept">Accept</a>
	<a class="ui-btn ui-corner-all ui-icon-back ui-btn-icon-notext" type="button" id="cardto_close">Close</a>
    </div>
	</form>
	</div>
</div>
