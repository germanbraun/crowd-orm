<?php
/*

Copyright 2017

Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA) -
Facultad de Informática
Universidad Nacional del Comahue

meta2eer.php

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
load('meta2lang.php');
load('objecttype.php', '../metamodel/');
load('subsumption.php', '../metamodel/');
load('relationship.php', '../metamodel/');
load('objecttypecardinality.php', '../metamodel/');
load('attribute.php', '../metamodel/');
use Wicom\Translator\Metamodel\ObjectType;
use Wicom\Translator\Metamodel\Relationship;
use Wicom\Translator\Metamodel\Subsumption;
use Wicom\Translator\Metamodel\Objecttypecardinality;
use Wicom\Translator\Metamodel\Attribute;

/*
 JSON EER example for static entities

 {
 "entities" : [{"name" : "Phone", "attrs":[]}, 
 			   {"name" : "CellPhone", "attrs":[]}, 
 			   {"name" : "FixedPhone", "attrs":[]}],
 "links" : [],
 }

 */

class Meta2EER extends Meta2Lang{

	/**
	 Translate a given JSON String representing an metamodel instance into a new JSON string of an EER class diagram.

	 @param json JSON metamodel string
	 @return a JSON EER string.

	 @see Meta2Lang class for description about the JSON format.
	 */


	public $eer;

	function __construct(){
		$this->eer = ["entities" => [],
				"links" => []
				
		];
	}


	function create_modelKF($json_str){
		$json = json_decode($json_str, true);

		$this->identifyEntitiesEER($json);

		 
	}
	
	
	private function getEntityNamefromAttr($js_attr,$entity){
		$attrforentity = []; 
		
		foreach ($js_attr as $attr){
			if ($attr["class name"] == $entity["name"]){
				array_push($attrforentity,$attr);
			}
		}
		return $attrforentity;
	}
	
	function identifyEntitiesEER($json){
		$js_entities = $json["Object type"];
		$js_attr = $json["Attribute"];
		
		
		if (!empty($js_attr)){
			
			foreach ($js_entities as $entity){
				$entity_obj = new ObjectType($entity["name"]);
				$eerentity = $entity_obj->equivEEREntity();
				$attr = $this->getEntityNamefromAttr($js_attr,$entity);
				
				if (!empty($attr)){
					foreach ($attr as $attr2){
						$attr_obj = new Attribute($attr2["class name"],$attr2["attribute name"],$attr2["datatype"]);
						$attr_eer = $attr_obj->equivEERAttr();
						array_push($eerentity["attrs"],$attr_eer);
					}
					array_push($this->eer["entities"],$eerentity);
				}
				else {
					array_push($this->eer["entities"],$eerentity);
				}
			}
		}
		else {
				foreach ($js_entities as $entity){
					$entity_obj = new ObjectType($entity["name"]);
					$eerentity = $entity_obj->equivEEREntity($entity);
					array_push($this->eer["entities"],$eerentity);
				}
		}
		
	}

	
	function get_json(){
		return json_encode($this->eer,true);
		 
	}
	
	
	
	
	
	
}

?>