<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   _modelinclude.php
   
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
   Echoes all the script tags in the given order. 

   $prefix can be setted to change the path of the Javascript URI.
 */

if (! isset($prefix)){
    $prefix = "./";
}

/**
   Order in which the script tags must be echoed.
 */
$order = [
    'diagram.js',
    'factories.js',
    'mymodel.js',
    'products.js',
    'server_connection.js'
];

foreach ($order as $script){
    echo "<script src=\"$prefix/js/model/$script\"></script>\n";
}

?>

