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

<div id="loginWidget" class="loginwidget">
    <div data-role="collapsible" data-collapsed="true"
    data-collapsed-icon="carat-d" data-expanded-icon="carat-u">
    <h1>Login / Logout</h1>
	<form>
	    <div id="loginForm">
	    <input type="text" id="login_username" data-mini="true" />
	    <input type="password" id="login_password" data-mini="true" />
	    <a class="ui-btn ui-corner-all ui-icon-check" type="button" id="login_login_btn">Login</a>
	    </div>
	    <div id="logoutForm">
		<p>Are you sure?</p>
		<div id="logout_username"></div>
		<a class="ui-btn ui-corner-all ui-icon-check" type="button" id="logout_logout_btn">Logout</a>
	    </div>
	</form>
    </div>
</div>
