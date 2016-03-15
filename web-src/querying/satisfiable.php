<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   satisfiable.php
   
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
   Return if the given diagram is satisfiable.
 */

require_once("../common/import_functions.php");

load("wicom.php", "../common/");

$wicom = new Wicom\Wicom();

if (array_key_exists('json', $_POST)){
    echo $wicom->is_satisfiable($_POST['json']);
}else{
    echo "Error, json parameter not founded.";
}
?>
