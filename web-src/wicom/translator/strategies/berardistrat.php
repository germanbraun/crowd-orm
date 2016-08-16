<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   berardistrat.php
   
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

/**
   I implement the method explained on "Reasoning on UML Class Diagrams" by 
   Daniela Berardi, Diego Calvanesse and Giuseppe De Giacomo.

   @see Translator class for description about the JSON format.
 */
class Berardi extends Strategy{

    /**
       Translate a JSON String into another format depending on 
       the given Builder.

       I implement the method explained on "Reasoning on UML Class Diagrams" by 
       Daniela Berardi, Diego Calvanesse and Giuseppe De Giacomo.
              
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
       Depending on $mult translate it into DL.

       @param $from True if we have to represent the "from" side (left one).

       @return A DL list part that represent the multiplicity restriction.
     */
    protected function translate_multiplicity($mult, $role, $from = true){
        if ($from){
            $arr_role = ["role" => $role];
            $sub1_DL = [1,
                        $arr_role];
            $sub0_DL = [0,
                        $arr_role];
        }else{
            $arr_role = ["inverse" => ["role" => $role]];
            $sub1_DL = [1,
                        $arr_role];
            $sub0_DL = [0,
                        $arr_role];
                        
        }
        
        $ret = null;
        switch($mult){
        case "1..1":
            $ret = ["intersection" => [
                ["mincard" => $sub1_DL],
                ["maxcard" => $sub1_DL]]];
            break;
        case "0..1":
            $ret = ["maxcard" => $sub1_DL];
            break;            
        case "1..*":
        case "1..n":
            $ret = ["mincard" => $sub1_DL];
            break;
        case "0..*":            
        case "0..n":
            $ret = [];
            break;
        }
        return $ret;
    }

    /**
       Translate only the association link.
       
       @param link A JSON object representing one association link.
    */
    protected function translate_association($link, $builder){
        $classes = $link["classes"];
        $mult = $link["multiplicity"];
            
        $builder->translate_DL([
            ["subclass" => [
                ["class" => "owl:Thing"],
                ["intersection" => [
                    ["forall" => [
                        ["role" => $link["name"]],
                        ["class" => $classes[0]]]],
                    ["forall" => [
                        ["inverse" => 
                         ["role" => $link["name"]]],
                        ["class" => $classes[1]]]]
                ]] //intersection
            ]] //subclass
        ]);

        $rest = $this->translate_multiplicity($mult[1], $link["name"]);
        if (($rest != null) and (count($rest) > 0)){
            // Multiplicity should be written.
            $lst = [
                ["subclass" => [
                    ["class" => $classes[0]],
                    $rest
                ]]
            ];
            $builder->translate_DL($lst);
        }

        $rest = $this->translate_multiplicity($mult[0], $link["name"], false);
        if (($rest != null) and (count($rest) > 0)){
            // Multiplicity should be written.
            $lst = [
                ["subclass" => [
                    ["class" => $classes[1]],
                    $rest
                ]]
            ];
            $builder->translate_DL($lst);
        }
    }

    /**
       Translate a generalization link into DL using the Builder.

       @param link A generaization link in a JSON string.
     */
    protected function translate_generalization($link, $builder){
        $parent = $link["parent"];
        
        foreach ($link["classes"] as $class){
            $lst = [
                ["subclass" => [
                    ["class" => $class],
                    ["class" => $parent]]]
            ];
            $builder->translate_DL($lst);
        }
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
            switch ($link["type"]){
            case "association":
                $this->translate_association($link, $builder);
                break;
            case "generalization":
                $this->translate_generalization($link, $builder);
                break;
            }
        }
        
    }
}

