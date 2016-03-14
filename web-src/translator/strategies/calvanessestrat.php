<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   calvanessetrans.php
   
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

class Calvanesse extends Strategy{

    /**
       Translate a JSON String into another format depending on 
       the given Builder.
       
       Calvanesse strategy do:
       
       - Each UML Class is a Class concept in DL.       

       @param json_str A String with a diagram representation in 
       JSON format.
       @param builder A Wicom\Translator\Builders\DocumentBuilder subclass instance.
       @return Wicom\Translator\Documents\Document subclass instance acording to the Builder given.
    */
    function translate($json_str, $builder){
        $json = json_decode($json_str, true);

        $builder->insert_header();
        
        // Classes
        $js_clases = $json["classes"];
        foreach ($js_clases as $class){
            $builder->insert_subclassof($class["name"], "owl:Thing");
        }
        
        $builder->insert_footer();

        return $builder->get_product();
    }
}
