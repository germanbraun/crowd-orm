<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   strategy.php
   
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

/**
   @see Translator class for description about the JSON format.
*/
abstract class Strategy{

    /**
       An instance of any QAPack subclass.

       @see Wicom\Translator\Strategies\QAPackages
     */
    protected $qapack = null;
    
    function __construct(){
    }

    /**
       Translate the given JSON String into the OWLlink XML string.
       
       @param json The JSON string
       @param build The Builder instance.
       @return An XML String.

       @see Translator class for description about the JSON format.
     */
    abstract function translate($json, $build);

    /**
       Generate queries appropiates for this queries using the Builder to store them in the document.
       
       @param $json a JSON string representing the user's model.
       @param $builder Wicom\Translator\Builders\DocumentBuilder 
    */
    function translate_queries($json, $builder){
        $this->qapack->generate_queries($json, $builder);
    }

    function analize_answer($reasoner_query, $reasoner_answer){
        $this->qapack->analize_answer($reasoner_query, $reasoner_answer);
        return $this->qapack->get_answer();
    }
    function get_answer(){
        return $this->qapack->get_answer();
    }

}
