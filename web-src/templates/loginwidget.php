<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   login.php
   
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

<div id="loginPopup" class="login-popup" data-dismissible="false" data-role="popup">
    <div data-role="header" class="login-header">
	<h1>Login</h1>
    </div>
    <div data-role="main" class="ui-content login-content">
	<form>
	    <input type="text" id="login_username" data-mini="true" />
	    <input type="password" id="login_password" data-mini="true" />
	    <a class="ui-btn ui-corner-all ui-icon-check" type="button" id="login_login_btn">Login</a>
	    <a class="ui-btn ui-corner-all ui-icon-back" type="button" id="login_cancel_btn">Cancel</a>
	</form>
    </div>
</div>
