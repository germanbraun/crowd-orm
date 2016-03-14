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

namespace Wicom\QueryGen;

class QueryGenerator{
    function __construct(){
    }

    /**
       I generate queries for checking diagram satisfability.

       @param $builder A Wicom\Translator\Builders\DocumentBuilder
       instance.
     */
    function gen_satisfiable($builder){
        $builder->insert_satisfiable();
    }

    /**
       I generate queries for checking satisfability per each class
       in the diagram. 

       @param $json_diagram a String in JSON format with the diagram.
       @param $builder A Wicom\Translator\Builders\DocumentBuilder
       instance.
    */
    function gen_class_satisfiable($json_diagram, $builder){
        //TODO: Create this method.
    }
}
    
?>
