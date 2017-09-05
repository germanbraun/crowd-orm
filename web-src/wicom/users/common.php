<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   common.php
   
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

/**
   Used by the API HTTP endpoints for removing all session variables and cookies
   related to the user profile.

   @see Example in http://php.net/manual/en/function.session-destroy.php .
*/
function logout_user(){
    // Unset the $_SESSION superglobal variable.
    $_SESSION = array();

    // Remove cookie if the session is stored there
    // (This behaviour depends on the PHP configuration).
    if (ini_get("session.use_cookies")) {
        $params = session_get_cookie_params();
        setcookie(session_name(), '', time() - 42000,
                  $params["path"], $params["domain"],
                  $params["secure"], $params["httponly"]
        );
    }

    // Destroy any other session regarded PHP internal data.
    session_destroy();
}
?>
