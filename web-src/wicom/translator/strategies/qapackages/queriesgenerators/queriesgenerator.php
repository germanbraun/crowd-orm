<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   queriesgenerator.php
   
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

namespace Wicom\Translator\Strategies\QAPackages\QueriesGenerators;

/**
   Superclass for all the queries generators available.
 */
abstract class QueriesGenerator{
    function __construct(){
    }

    /**
       Generate on the $builder all the queries for this generator.

       @param $json_str A String in JSON format for the diagram.
       @param $builder A Wicom\Translator\Builders\DocumentBuilder subclass.
     */
    abstract function generate_all_queries($json_str, $builder);
}
    
?>
