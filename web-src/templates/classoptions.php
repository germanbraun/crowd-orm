<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   classoptions.php
   
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
<div class="classOptions" data-role="controlgroup" data-mini="true"
     data-type="vertical" style="visible:false, z-index:1, position:absolute" >
    <input type="hidden" id="cassoptions_classid" name="classid" value="<%= classid %>" />
    <a class="ui-btn ui-corner-all ui-icon-edit ui-btn-icon-notext" type="button" id="editclass_button">Edit</a>
    <a class="ui-btn ui-corner-all ui-icon-delete ui-btn-icon-notext" type="button" id="deleteclass_button">Delete</a>
</div>
