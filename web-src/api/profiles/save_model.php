<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   save_model.php
   
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

load('model.php', '../../wicom/users/');
load('user.php', '../../wicom/users/');
load('common.php', '../../wicom/users/');

use Wicom\Users\Model;
use Wicom\Users\User;

session_start();

if (!array_key_exists('username', $_SESSION) and
    ($_SESSION['username'] != null)){
    die('Session has not been started.');
}

if ((!array_key_exists('model_name', $_REQUEST)) and 
    (!array_key_exists('json', $_REQUEST))){
    die('Missing parameters.');
}
    

$model = Model::retrieve($_REQUEST['model_name'], $_SESSION['username']);

if ($model == null){
    $user = User::retrieve($_SESSION['username']);
    if ($user == null){
        logout_user();
        die('Error trying to save the model.');
    }
    $model = new Model($_REQUEST['model_name'], $user);
}

$model->set_json($_REQUEST['json']);
if (!$model->save()){
    die('Error, model could not be saved. Maybe internal error?');
}

echo 'Done.';
?>
