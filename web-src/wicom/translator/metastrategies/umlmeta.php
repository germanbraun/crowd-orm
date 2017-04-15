<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   umlmeta.php
   
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

use function \load;
load('metastrategy.php');

class UMLMeta extends MetaStrategy{
    function create_metamodel($json, $build){
        $json = json_decode($json_str, true);
        
        // Classes
        $js_clases = $json["classes"];
        foreach ($js_clases as $class){
            $builder->insert_subclassof($class["name"], "owl:Thing");
        }

        $this->generate_links($json, $builder); 
    }
}
?>
