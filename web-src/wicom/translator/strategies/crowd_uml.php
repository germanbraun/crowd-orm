<?php 
/* 

   Copyright 2016 GILIA, Departamento de Teoría de la Computación, Universidad Nacional del Comahue
   
   Author: GILIA

   crowd_uml.php
   
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
   This module implements the graphical-oriented UML encoding for crowd.
   Read paper "" for more details about formalisation.

   @see Translator class for description about the JSON format.
 */
class UMLcrowd extends Strategy{

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
       Generates internal classes for reasoning on cardinalities.
       
	   @param $role associated role
	   @param $classes classes participating in association $link with multiplicity $mult

    */

	protected function generate_internal_classes($role, $classes, $builder, $withclass=true){

		if ($withclass){

		$builder->translate_DL([
            ["subclass" => [   //cambiar a equivalent
					["class" => $classes[0]],
					["intersection" => [
							["class" => $classes[0]],
                			["mincard" => [1, ["inverse" => ["role" => $role]]]]]]
			]]]);
		
		$builder->translate_DL([
            ["subclass" => [
					["class" => $classes[0]],
					["intersection" => [
							["class" => $classes[0]],
                			["maxcard" => [1, ["inverse" => ["role" => $role]]]]]]
			]]]);

		
		$builder->translate_DL([
            ["subclass" => [
					["class" => $classes[1]],
					["intersection" => [
							["class" => $classes[1]],
                			["mincard" => [1, ["inverse" => ["role" => $role]]]]]]
			]]]);
		
		$builder->translate_DL([
            ["subclass" => [
					["class" => $classes[1]],
					["intersection" => [
							["class" => $classes[1]],
                			["maxcard" => [1, ["inverse" => ["role" => $role]]]]]]
			]]]);
		}
		else {

		$builder->translate_DL([
            ["equivalentclasses" => [
						["class" => $classes[0]],
						["intersection" => [
								["class" => $classes[0]],
                				["mincard" => [1, ["role" => $role]]]]]
			]]]);
		
/*		$builder->translate_DL([
            ["subclass" => [
					["class" => $classes[0]],
					["intersection" => [
							["class" => $classes[0]],
                			["maxcard" => [1, ["role" => $role]]]]]
			]]]);

		
		$builder->translate_DL([
            ["subclass" => [
					["class" => $classes[1]],
					["intersection" => [
							["class" => $classes[1]],
                			["mincard" => [1, ["inverse" => ["role" => $role]]]]]]
			]]]);
		
		$builder->translate_DL([
            ["subclass" => [
					["class" => $classes[1]],
					["intersection" => [
							["class" => $classes[1]],
                			["maxcard" => [1, ["inverse" => ["role" => $role]]]]]]
			]]]);*/

		}

		return $builder;

	}


    /**
       Depending on $mult translate it into DL.

       @param $from True if we have to represent the right cardinality.

       @return A DL list part that represent the multiplicity restriction.
     */
    protected function translate_multiplicity($mult, $role, $classes, $from = true){
 
        if ($from) {
            $arr_role = ["role" => $role];
            $sub1_DL = [1,
                        $arr_role];
            $sub0_DL = [0,
                        $arr_role];
        }

		else {
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
       Translate associations without class together with cardinalities 0..*, 1..*, 0..1 and 1..1 for both directions.
       
       @param link A JSON object representing one association link without class.
    */

    protected function translate_association_without_class($link, $builder){
        $classes = $link["classes"];
        $mult = $link["multiplicity"];

		$assoc_without_class = [
			["domain" => [["role" => $link["name"]], ["class" => $classes[0]]]],
			["range" => [["role" => $link["name"]], ["class" => $classes[1]]]],
			["equivalentclasses" => [["class" => $classes[0]."_".$link["name"]."_"."min"],
						            ["intersection" => [["class" => $classes[0]],
                				                        ["mincard" => [1, ["role" => $link["name"]], ["top" => "owl:Thing"]]]]
									]]
			],
			["equivalentclasses" => [["class" => $classes[0]."_".$link["name"]."_"."max"],
						            ["intersection" => [["class" => $classes[0]],
                				                        ["maxcard" => [1, ["role" => $link["name"]], ["top" => "owl:Thing"]]]]
									]]
			],
			["equivalentclasses" => [["class" => $classes[1]."_".$link["name"]."_"."min"],
						            ["intersection" => [["class" => $classes[1]],
                				                        ["mincard" => [1, ["inverse" => ["role" => $link["name"]]], ["top" => "owl:Thing"]]]]
									]]
			],
			["equivalentclasses" => [["class" => $classes[1]."_".$link["name"]."_"."max"],
						            ["intersection" => [["class" => $classes[1]],
                				                        ["maxcard" => [1, ["inverse" => ["role" => $link["name"]]], ["top" => "owl:Thing"]]]]
									]]
			]

		];
            

		$right = null;
		switch ($mult[0]){
				
			case null : $right = [];
						break;
			case "0..1" : $right = [
							["subclass" => [["class" => $classes[0]],
						            		["maxcard" => [1, ["role" => $link["name"]], ["class" => $classes[1]]]]]
									]];
				  		break;
			case "1..*" : $right = [
							["subclass" => [["class" => $classes[0]],
						            		["mincard" => [1, ["role" => $link["name"]], ["class" => $classes[1]]]]]
									]];
						break;
			case "1..1" : $right = [
							["subclass" => [["class" => $classes[0]],
						            		["mincard" => [1, ["role" => $link["name"]], ["class" => $classes[1]]]]]],
							[ "subclass" => [["class" => $classes[0]],
						            		["maxcard" => [1, ["role" => $link["name"]], ["class" => $classes[1]]]]]]
									];
						break;
			default:  
				throw new \Exception("Undefined right multiplicity between: ".$classes[0]." and ".$classes[1]);

		}


		$left = null;
		switch ($mult[1]){

			case null : $left = [];
						break;
			case "0..1" : $left = [
							["subclass" => [["class" => $classes[1]],
						            		["maxcard" => [1, ["inverse" => ["role" => $link["name"]]], ["class" => $classes[0]]]]]
									]];
						break; 
			case "1..*" : $left = [
							["subclass" => [["class" => $classes[1]],
						            		["mincard" => [1, ["inverse" => ["role" => $link["name"]]], ["class" => $classes[0]]]]]
									]];
						break;
			case "1..1" : $left = [
							["subclass" => [["class" => $classes[1]],
						            		["mincard" => [1, ["inverse" => ["role" => $link["name"]]], ["class" => $classes[0]]]]]],	
							["subclass" => [["class" => $classes[1]],
						            		["maxcard" => [1, ["inverse" => ["role" => $link["name"]]], ["class" => $classes[0]]]]]]
								 ];

						break;

			default: 
				throw new \Exception("Undefined left multiplicity between: ".$classes[0]." and ".$classes[1]);
		}


		foreach ($right as $rightelem) {
			
			array_push($assoc_without_class, $rightelem);
		}

		foreach ($left as $leftelem) {
			
			array_push($assoc_without_class, $leftelem);
		}

		$builder->translate_DL($assoc_without_class);


    }


    /**
       Translate only the association link.
       
       @param link A JSON object representing one association link with class.
    */
    protected function translate_association_with_class($link, $builder){
        $classes = $link["classes"];
        $mult = $link["multiplicity"];
            
        $builder->translate_DL([
            ["subclass" => [
                			["exists" => $link["name"]],
							["class" => $classes[0]]
			]]]);

		$builder->translate_DL([
            ["subclass" => [
                ["exists" => [ 
					["inverse" => $link["name"]]]],
				["class" => $classes[1]]
			]]]);


		$rest = $this->generate_internal_classes($link["name"], $classes,true);

    }

    /**
       Translate a generalization link into DL using the Builder.

       @param link A generaization link in a JSON string.
     */
    protected function translate_generalization($link, $builder){
        $parent = $link["parent"];

        foreach ($link["classes"] as $class){
            // Translate the parent-child relation
            $lst = [
                ["subclass" => [
                    ["class" => $class],
                    ["class" => $parent]]]
            ];
            $builder->translate_DL($lst);
        }

        // Again the same for each, so it will create an organized OWLlink:
        // First all classes are subclasses and then the disjoints and covering.
        foreach ($link["classes"] as $class){

            // Translate the disjoint constraint DL
            if (in_array("disjoint",$link["constraint"])){
                $index = array_search($class, $link["classes"]);
                $complements = array_slice($link["classes"], $index+1);
                
                // Make the complement of Class_index for each j=index..n
                $comp_dl = [];
                foreach ($complements as $compclass){
                    array_push($comp_dl,
                               ["complement" =>
                                ["class" => $compclass]]
                    );
                }

                
                // Create the disjoint DL with the complements.
                $lst = null;
                if (count($complements) > 1){
                    $lst = [
                        ["subclass" => [
                            ["class" => $class],
                            ["intersection" => 
                             $comp_dl]]]

                    ];
                    
                    $builder->translate_DL($lst);
                }else{ if (count($complements) == 1){                        
                        $lst = [["subclass" => [
                            ["class" => $class],
                            $comp_dl[0]
                        ]]];

                        $builder->translate_DL($lst);
                    }
                }
                
                
                
            } // end if-disjoint
        } // end foreach

        // Translate the covering constraint
        if (in_array("covering", $link["constraint"])){
            $union = [];
            foreach ($link["classes"] as $classunion){
                array_push($union, ["class" => $classunion]);
            }
            $lst = [["subclass" => [
                ["class" => $parent],
                ["union" => $union]
            ]]];
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
                $this->translate_association_without_class($link, $builder);
                break;
            case "generalization":
                $this->translate_generalization($link, $builder);
                break;
            }
        }
        
    }
}

