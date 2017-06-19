<?php 
/*

Copyright 2017 

Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA) -
Facultad de Informática
Universidad Nacional del Comahue

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
	JSON metamodel example for static entities UML
	
{
"Object type" : [{"name" : "Phone"},
			     {"name" : "CellPhone"},
		         {"name" : "FixedPhone"}],
"Subsumption" : [{"name" : "r1",
				  "parent" : "Phone",
			      "children" : ["CellPhone", "FixedPhone"]}],
"Role" : [],
"Qualified relationship" : [],
"Shared aggregate" : [],
"Composite aggregate" : [],
"Attribute" : [],
"Multivalued attribute" : [],
"Mapped to" : [],
"Composite attribute" : [],
"Value type" : [],
"Dimensional value type" : [],
"Data type" : [],
"Weak object type" : [],
"Associative object type" : [],
"Nested Object type" : [],
"Qualifier" : []
}

 */


class UMLMeta extends MetaStrategy{
	
	/**
	 Translate a given JSON String representing a UML class diagram into a new JSON metamodel string.
	
	 @param json JSON UML string
	 @return a JSON metamodel string.
	
	 @see MetaStrategy class for description about the JSON format.
	 */
	
	
	public $meta;
	
	function __construct(){
		$this->meta = ["Object type" => [],
					   "Subsumption" => [],
					   "Association" => [],
					   "Object type cardinality" => [],
					   "Attribute" => []
					  ];
	}
	
	
    function create_metamodel($json_str){
        $json = json_decode($json_str, true);
        
 //       print_r($json);

        $this->identifyClasses($json);
        $this->identifySubsumption($json);
      	$this->idenfityBinaryAssoc0NWithoutRoles($json);
         
    }
    
    function identifyClasses($json){
    	$js_classes = $json["classes"];
    	
    	foreach ($js_classes as $class){
    		$objecttype = new ObjectType($class["name"]);
    		array_push($this->meta["Object type"],$objecttype->get_json_array());
    		
    		$js_attr = $class["attrs"];
    		
    		if (!empty($js_attr)){
    			foreach ($js_attr as $attr){
    				$attr_obj = new Attribute($class["name"],$attr["name"],$attr["datatype"]);
    				array_push($this->meta["Attribute"],$attr_obj->get_json_array());
    			}
    		}
    		
    	}
    	
    }
    
    function identifySubsumption($json){
    	$json_links = $json["links"];
    	$rest = array_filter($json_links,function($gen){return $gen["type"] == "generalization";});
    	
    	foreach ($rest as $sub){
    		$sub_obj = new Subsumption($sub["name"],$sub["parent"],$sub["classes"]);
    		array_push($this->meta["Subsumption"],$sub_obj->get_json_array());
    		
    	}
    }
    
    function idenfityBinaryAssoc0NWithoutRoles($json){
    	$json_links = $json["links"];
    	$rest = array_filter($json_links,function($gen){return $gen["type"] == "association";});
    	
    	foreach ($rest as $assoc){
    		$assoc_obj = new Relationship($assoc["name"], $assoc["classes"]);
    		array_push($this->meta["Association"],$assoc_obj->get_json_array());
    		$type_card_obj = new Objecttypecardinality($assoc["name"], $assoc["multiplicity"]);
    		array_push($this->meta["Object type cardinality"],$type_card_obj->get_json_array());
    	
    	}
    	
    }
    
    function get_json(){
    	return json_encode($this->meta,true);
    	
    }
    
    
}
?>
