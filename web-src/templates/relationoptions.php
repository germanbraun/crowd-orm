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
<!--  
<div class="relationOptions" style="visible:false, z-index:1, position:absolute">
    <input type="hidden" id="relationoptions_classid"  name="classid"  value="<%= classid %>" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal">
	<select data-mini="true" data-inline="true" data-native-menu="false" id="cardfrom">
	    <option value="zeromany">0..*</option>
	    <option value="onemany">1..*</option>
	    <option value="zeroone">0..1</option>
	    <option value="oneone">1..1</option>
	</select>
	<a class="ui-btn ui-corner-all ui-icon-arrow-r ui-btn-icon-notext" type="button" id="association_button">Association</a>
	<select data-mini="true" data-inline="true" data-native-menu="false" id="cardto" >
	    <option value="zeromany">0..*</option>
	    <option value="onemany">1..*</option>
	    <option value="zeroone">0..1</option>
	    <option value="oneone">1..1</option>
	</select>
    </div>

    <a class="ui-btn ui-corner-all ui-icon-arrow-u ui-btn-icon-notext" type="button" id="isa_button">Is A</a>
    <fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
	<input type="checkbox" name="chk-covering" id="chk-covering"/>
	<label for="chk-covering">Covering</label>
	<input type="checkbox" name="chk-disjoint" id="chk-disjoint" />
	<label for="chk-disjoint">Disjoint</label>
    </fieldset>
</div>   -->

<div class="relationOptions" style="visible:false, z-index:1, position:absolute">
    <input type="hidden" id="relationoptions_classid"  name="classid"  value="<%= classid %>" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal" style="float: left">
	<form>
    	<input type="hidden" id="cardfrom-1" name="cardfrom-1" value="<%= classid %>" />
    	<input data-mini="true" placeholder="0" type="text" id="editclass_input" size="2" maxlength="4" />
    	<input type="hidden" id="cardfrom-2" name="cardfrom-2" value="<%= classid %>" />
    	<input data-mini="true" placeholder="*" type="text" id="editclass_input" size="2" maxlength="4" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal">
	<a class="ui-btn ui-corner-all ui-icon-check ui-btn-icon-notext" type="button" id="editclass_button">Accept</a>
	<a class="ui-btn ui-corner-all ui-icon-back ui-btn-icon-notext" type="button" id="close_button">Close</a>
    </div>
	</form>
	</div>
	
	<div style="float: left">
	<a class="ui-btn ui-corner-all ui-icon-arrow-r ui-btn-icon-notext" type="button" id="association_button">Association</a>
	</div>
	<div data-role="controlgroup" data-mini="true" data-type="horizontal" style="float: right">
	<form>
    	<input type="hidden" id="cardto-1" name="cardto-1" value="<%= classid %>" />
    	<input data-mini="true" placeholder="0" type="text" id="editclass_input" size="2" maxlength="4" />
    	<input type="hidden" id="cardto-2" name="cardto-2" value="<%= classid %>" />
    	<input data-mini="true" placeholder="*" type="text" id="editclass_input" size="2" maxlength="4" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal">
	<a class="ui-btn ui-corner-all ui-icon-check ui-btn-icon-notext" type="button" id="editclass_button">Accept</a>
	<a class="ui-btn ui-corner-all ui-icon-back ui-btn-icon-notext" type="button" id="close_button">Close</a>
    </div>
	</form>
	</div>
</div>
