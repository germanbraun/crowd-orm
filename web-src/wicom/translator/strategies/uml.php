<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   uml.php
   
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

namespace Wicom\Translator\Strategies;

use function \load;
load('strategy.php');

abstract class UML extends Strategy{
    /**
       Translate a JSON String into another format depending on 
       the given Builder.
              
       - Each UML Class is a Class concept in DL.

       @param json_str A String with a diagram representation in 
       JSON format.
       @param builder A Wicom\Translator\Builders\DocumentBuilder subclass instance.

       @see Translator class for description about the JSON format.
    */
    function translate($json_str, $builder){
    
        $json = json_decode($json_str, true);

        // Classes
        $js_clases = $json["classes"];
        foreach ($js_clases as $class){
            $builder->insert_subclassof($class["name"], "owl:Thing");
        }

        $this->translate_links($json, $builder);
    }

    /**
       Translate only the links from a JSON string with links using
       the given builder.
       @param json A JSON object, the result from a decoded JSON 
       String.
       @return false if no "links" part has been provided.
    */
    protected abstract function translate_links($json, $builder);
}
?>
