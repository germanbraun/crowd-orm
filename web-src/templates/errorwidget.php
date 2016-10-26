<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   errorwidget.php
   
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
<div class="error-popup" data-dismissible="false"  data-role="popup">
    <div data-role="header" class="error-header">
	<h1> Error: </h1>
    </div>
    <div data-role="main" class="ui-content error-content">
	<dl>
	    <dt>Status:</dt><dd>
		<div id="errorstatus_text"></div>
	    </dd>
	    <dt>Server Answer:</dt><dd>
		<pre>
		    <div id="errormsg_text"></div>
		</pre>
	    </dd>
	</dl>
	<a data-rel="back" id="errorwidget_hide_btn"
	   class="ui-corner-all ui-btn ui-icon-back ui-btn-icon-left">Hide</a>
    </div>
</div>
