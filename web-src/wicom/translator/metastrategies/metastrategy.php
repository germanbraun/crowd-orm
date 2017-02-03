<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   metastrategy.php
   
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

namespace Wicom\Translator\MetaStrategies;

/**
   @see Metamodel translator class for description about the JSON format.
*/
abstract class MetaStrategy{
    function __construction(){
        
    }

    /**
     Translate the given JSON String into the OWL XML string according to metamodel rules defined in
     
     (a) Fillottrani, Keet. Conceptual Model Interoperability: A Metamodel-driven Approach. 2014.
     (b) Fillottrani, Keet. KF metamodel formalization. 2014.
      
     @param json The JSON string
     @param build The Builder instance.
     @return An XML String.
    
     @see Translator class for description about the JSON format.
     */
    abstract function create_metamodel($json);
}
?>
