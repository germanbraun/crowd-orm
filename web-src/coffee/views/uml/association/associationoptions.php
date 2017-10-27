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
    <input type="hidden" id="umlrelationoptions_classid"  name="classid"  value="<%= classid %>" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal" style="float: left">
	     <form id="left-rel">
    	    <input type="hidden" id="umlrelationoptions_classid" name="classid" value="<%= classid %>" />
    	    <input data-mini="true" placeholder="0" type="text" id="umlcardfrom-1" size="2" maxlength="4" />
    	    <input type="hidden" id="umlrelationoptions_classid" name="classid" value="<%= classid %>" />
    	    <input data-mini="true" placeholder="*" type="text" id="umlcardfrom-2" size="2" maxlength="4" />
	        <input data-mini="true" placeholder="role1" type="text" id="umlrole-from" size="2" maxlength="4" />
	    </form>
    </div>

    <div data-role="controlgroup" data-mini="true" data-type="horizontal" style="float: left">
	     <form id="name-rel">
	        <input data-mini="true" placeholder="name" type="text" size="4" maxlength="10" id="umlassoc_name" />
	        <div data-role="controlgroup" data-mini="true" data-type="horizontal">
		          <a class="ui-btn ui-corner-all ui-icon-arrow-r ui-btn-icon-notext" type="button" id="umlassociation_button">Association</a>
		          <a class="ui-btn ui-corner-all ui-btn-icon-notext" type="button" id="umlassoc_class_button">Association Class</a>
	        </div>
	     </form>
    </div>

    <input type="hidden" id="umlrelationoptions_classid"  name="classid"  value="<%= classid %>" />
    <div data-role="controlgroup" data-mini="true" data-type="horizontal" style="float: right">
	     <form id="right-rel">
    	    <input type="hidden" id="umlrelationoptions_classid" name="classid" value="<%= classid %>" />
    	    <input data-mini="true" placeholder="0" type="text" id="umlcardto-1" size="2" maxlength="4" />
    	    <input type="hidden" id="umlrelationoptions_classid" name="classid" value="<%= classid %>" />
    	    <input data-mini="true" placeholder="*" type="text" id="umlcardto-2" size="2" maxlength="4" />
	        <input data-mini="true" placeholder="role2" type="text" id="umlrole-to" size="2" maxlength="4" />
	     </form>
    </div>
</div>
