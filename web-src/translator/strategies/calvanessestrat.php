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
       Depending on $mult translate it into DL.

       @param $from True if we have to represent the "from" side (left one).
       @return A DL list part that represent the multiplicity restriction.
     */
    protected function translate_multiplicity($mult, $role, $from = true){
        if ($from){
            $sub1_DL = [1,
                        ["role" => $role]];
            $sub1_DL = [0,
                        ["role" => $role]];
        }else{
            $sub1_DL = [1,
                        ["inverse" => 
                         ["role" => $role]]];
            $subo_DL = [0,
                        ["inverse" => 
                         ["role" => $role]]];
                        
        }
        
        $ret = null;
        switch($mult){
        case "1..1":
            $ret = ["intersection" => [
                ["mincard" => $sub1_DL],
                ["maxcard" => $sub1_DL]]];
            break;
        case "0..1":
            $ret = ["intersection" => [
                ["mincard" => $sub0_DL],
                ["maxcard" => $sub1_DL]]];
            break;            
        case "1..*":
        case "1..n":
            $ret = ["mincard" => $sub1_DL];
            break;
        case "0..*":
        case "0..n":
            $ret = ["mincard" => $sub0_DL];
            break;
        }
        return $ret;
    }
    
    /**
       Translate only the links from a JSON string with links using
       the given builder.
       @param json A JSON object, the result from a decoded JSON 
       String.
       @return false if no "links" part has been provided.
     */
    protected function translate_links($json, $builder){
        if (! array_key_exists("links", $json)){
            return false;
        }
        $js_links = $json["links"];
        foreach ($js_links as $link){
            $classes = $link["classes"];
            $mult = $link["multiplicity"];
            
            $builder->translate_DL([
                ["subclass" => [
                    ["exists" =>
                     ["role" => $link["name"]]],
                    ["class" => $link["classes"][0]]]],                
                ["subclass" => [
                    ["exists" =>
                     ["inverse" =>
                      ["role" => $link["name"]]]],
                    ["class" => $classes[0]]]]
            ]);

            $rest = $this->translate_multiplicity($mult[1], $link["name"]);
            $lst = [
                ["subclass" => [
                    ["class" => $classes[0]],
                    $rest
                ]]
            ];
            $builder->translate_DL($lst);

            $rest = $this->translate_multiplicity($mult[0], $link["name"], false);
            $lst = [
                ["subclass" => [
                    ["class" => $classes[1]],
                    $rest
                ]]
            ];
            $builder->translate_DL($lst);
            

        }
        
    }
}

