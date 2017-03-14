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

/**
   Check if the user is logged in, if not make the loggin.
*/

require_once('../../common/import_functions.php');

load('user.php', '../../wicom/users/');
load('common.php', '../../wicom/users/');

use Wicom\Users\User;

/*
  Do some checkings:
  
  Session already initialized -> do nothing.
  Username GET or POST key doesn't exists -> logout.
  Username wrong -> logout
  Password wrong -> logout

*/
session_start();
if (!array_key_exists('username', $_SESSION) and
    ($_SESSION['username'] != null)){
    die('Session already initialized.');
}

if ((!array_key_exists('username', $_REQUEST)) or
    (!array_key_exists('password', $_REQUEST))){
    logout_user();    
    die('Missing parameters.');
}

$user = User::retrieve($_REQUEST['username']);

if (($user != null) and ($user->check_password($_REQUEST['password']))){
    // Username and password are registered, accept login.
    session_reset();
    $_SESSION['username'] = $user->get_name();
    echo "Logged in";
}else{
    logout_user();
    echo "Not logged in";
}

session_commit();

?>
