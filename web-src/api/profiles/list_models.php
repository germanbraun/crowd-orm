<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   list_models.php
   
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

require_once('../../common/import_functions.php');

load('user.php', '../../wicom/users/');
load('common.php', '../../wicom/users/');

use Wicom\Users\User;

session_start();

if (!array_key_exists('username', $_SESSION) and
    ($_SESSION['username'] != null)){
    die('Session has not been started.');
}

$user = User::retrieve($_SESSION['username']);

if ($user == null){
    logout_user();
    die('Session has not been started.');
}

// Model exists, retrieve the JSON.

echo json_encode($user->get_model_list());
?>
