<?php
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   translator.php
   
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

namespace Wicom\Translator;

use function \load;

use function \json_decode;

/**
   I translate a JSON formatted diagram into something else depending on the Builder instance given.
   
   1. Give a Strategy translator instance for specifying the algorithm for translating the diagram.
   2. Give a Builder for specifying the output format.

   # JSON Format

   We expect the following fields:

   - `classes` : An Array of classes information. Each class should have:
     - `attrs` An array of strings representing all attributes names
     - `methods` An array of strings representing all attributes names
     - `name` A string which represent the name of the class.
   - links : An array of links information. Each link should have:
     - `classes` : An array of strings with the name of the classes involved on the relationship.
     - `multiplicity` : An array of strings with the multiplicity on each class side.
     - `name` : A string with the name of the link.
     - `type` : A string with the type name of the link. Could be: "association", "generalization".

   ## Example
   @code{json}
   {"classes": [
     {"attrs":[], "methods":[], "name": "Person"},
     {"attrs":[], "methods":[], "name": "Cellphones"}],
    "links": [
     {"classes": ["Person", "Cellphones"],
      "multiplicity": ["1..1", "1..*"],
      "name": "hasCellphone",
      "type": "association"}
      ]
   }
   @endcode
     
 */
class Translator{
    protected $strategy = null;
    protected $builder = null;
    
    /**
       The translator should add queries?
     */
    protected $with_queries = true;

    function __construct($strategy, $builder){
        $this->strategy = $strategy;
        $this->builder = $builder;
        $this->with_queries = true;
    }

    function set_with_queries($bool){
        $this->with_queries = $bool;
    }

    function get_with_queries(){
        return $this->with_queries;
    }

    /**
       @param json A String.
       @return an XML OWLlink String.
     */
    function to_owllink($json){
        $json_obj = json_decode($json, true);
        $this->builder->insert_header();
        
        $this->strategy->translate($json, $this->builder);
        
        if (array_key_exists("owllink", $json_obj)){
            $this->builder->insert_owllink($json_obj["owllink"]);
        }

        if ($this->with_queries){
            $this->strategy->translate_queries($json, $this->builder);                
        }
        
        $this->builder->insert_footer();
        // return $builder->get_product();
        $document = $this->builder->get_product();        
        return $document->to_string();
    }
}
