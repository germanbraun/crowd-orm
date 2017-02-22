<?php
/*

Copyright 2017 

Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA) -
Facultad de Informática
Universidad Nacional del Comahue

metamodellingtest.php
 
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

require_once("common.php");

// use function \load;
load("umlmeta.php", "wicom/translator/metastrategies/");
load("meta2eer.php", "wicom/translator/metastrategies/");
load("meta2orm.php", "wicom/translator/metastrategies/");

use Wicom\Translator\Metastrategies\UMLMeta;
use Wicom\Translator\Metastrategies\Meta2ORM;
use Wicom\Translator\Metastrategies\Meta2EER;



class MetamodellingTest extends PHPUnit_Framework_TestCase
{

	##
	# Test if we can generate the metamodel equivalent to the given UML diagram with classes and subsumptions
	public function testUMLClassAndGen2Metamodel(){
		$json = <<< EOT
{
"classes": [{"name":"Phone", "attrs":[], "methods":[]},
		    {"name":"CellPhone", "attrs":[], "methods":[]},
			{"name":"FixedPhone", "attrs":[], "methods":[]}],
"links":   [
			{"classes" : ["CellPhone", "FixedPhone"],
			 "multiplicity" : null,
			 "name" : "r1",
			 "type" : "generalization",
			 "parent" : "Phone",
			 "constraint" : []
			}
		   ]
}
EOT;
		
$expected = <<< EOT
{
"Object type" : [{"name" : "Phone"},
			     {"name" : "CellPhone"},
		         {"name" : "FixedPhone"}],
"Subsumption" : [{"name" : "r1",
				  "parent" : "Phone",
			      "children" : ["CellPhone", "FixedPhone"]}],
"Association" : [],
"Object type cardinality" : [],
"Attribute" : []
}
EOT;
		
		$strategy = new UMLMeta();
		$strategy->create_metamodel($json);
		print_r($strategy->meta);
		$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
		
	}
	
	
	##
	# Test if we can generate the metamodel equivalent to the given UML diagram with classes and associations.
	# Cardinalities are null.
	public function testUMLBinaryAssoc0NWithoutRolesMetamodel(){
		$json = <<< EOT
{
"classes": [{"name":"PhoneCall", "attrs":[], "methods":[]},
		    {"name":"Phone", "attrs":[], "methods":[]}],
"links":   [
			{"name" : "r1",
			 "classes" : ["PhoneCall", "Phone"],
			 "multiplicity" : ["0..*","0..*"],
			 "type" : "association"
			}
		   ]
} 
EOT;
	
		$expected = <<< EOT
{
"Object type" : [{"name" : "PhoneCall"},
			     {"name" : "Phone"}],
"Subsumption" : [],
"Association" : [{"name" : "r1",
			      "classes" : ["PhoneCall", "Phone"]}],
"Object type cardinality" : [{"association" : "r1",
							  "min..max left" : "0..*",
							  "min..max right" : "0..*"}],
"Attribute" : []
}
EOT;
	
		$strategy = new UMLMeta();
		$strategy->create_metamodel($json);
		print_r($strategy->meta);
		$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
	
	}
	

	##
	# Test if we can generate the metamodel equivalent to the given UML diagram with classes and attributes.
	# Cardinalities are null.
	public function testUMLWithAttributesMetamodel(){
		$json = <<< EOT
{
"classes": [{"name": "PhoneCall", "attrs":[{"name" : "date", "datatype" : "String"}], "methods":[]},
		    {"name": "Phone", "attrs":[{"name" : "location", "datatype" : "String"}, 
		    						   {"name" : "owner", "datatype" : "String"}], "methods":[]}
		   ],
"links": []
}
EOT;
	
		$expected = <<< EOT
{
"Object type" : [{"name" : "PhoneCall"},
			     {"name" : "Phone"}],
"Subsumption" : [],
"Association" : [],
"Object type cardinality" : [],
"Attribute"   : [{"class name" : "PhoneCall", "attribute name" : "date", "datatype" : "String"},
				 {"class name" : "Phone", "attribute name" : "location", "datatype" : "String"},
				 {"class name" : "Phone", "attribute name" : "owner", "datatype" : "String"}]
}
EOT;
	
		$strategy = new UMLMeta();
		$strategy->create_metamodel($json);
		print_r($strategy->meta);
		$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
	
	}
	
	
	##
	# General Test from UML to Metamodel
	public function testUMLMetamodel(){
		$json = <<< EOT
{
"classes": [{"name":"PhoneCall", "attrs":[{"name" : "date", "datatype" : "String"}], "methods":[]},
		    {"name":"Phone", "attrs":[{"name" : "location", "datatype" : "String"}, 
		    						  {"name" : "owner", "datatype" : "String"}], "methods":[]},
			{"name":"CellPhone", "attrs":[], "methods":[]},
			{"name":"FixedPhone", "attrs":[], "methods":[]}],
"links":   [
			{"classes" : ["CellPhone", "FixedPhone"],
			 "multiplicity" : null,
			 "name" : "r1",
			 "type" : "generalization",
			 "parent" : "Phone",
			 "constraint" : []
			},
			{"name" : "r2",
			 "classes" : ["PhoneCall", "Phone"],
			 "multiplicity" : ["0..*","0..*"],
			 "type" : "association"
			}
		   ]
}
EOT;
	
		$expected = <<< EOT
{
"Object type" : [{"name" : "PhoneCall"},
			     {"name" : "Phone"},
				 {"name" : "CellPhone"},
		         {"name" : "FixedPhone"}],
"Subsumption" : [{"name" : "r1",
				  "parent" : "Phone",
			      "children" : ["CellPhone", "FixedPhone"]}],
"Association" : [{"name" : "r2",
			      "classes" : ["PhoneCall", "Phone"]}],
"Object type cardinality" : [{"association" : "r2",
							  "min..max left" : "0..*",
							  "min..max right" : "0..*"}],
"Attribute"   : [{"class name" : "PhoneCall", "attribute name" : "date", "datatype" : "String"},
				 {"class name" : "Phone", "attribute name" : "location", "datatype" : "String"},
				 {"class name" : "Phone", "attribute name" : "owner", "datatype" : "String"}]
}
EOT;
	
		$strategy = new UMLMeta();
		$strategy->create_metamodel($json);
		print_r($strategy->meta);
		$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
	
	}
	
	
	## ORM
	
	# Test translation from metamodel object types to ORM entity types.
	public function testMetamodelObjectType2ORM(){
		$json = <<< EOT
{
"Object type": [{"name":"PhoneCall"},
		    	{"name":"Phone"},
				{"name":"CellPhone"},
				{"name":"FixedPhone"}],
"Subsumption" : [],
"Association" : [],
"Object type cardinality" : [],
"Attribute"   : []
}
EOT;

		$expected = <<< EOT
{
"entity types" : [{"name" : "PhoneCall"},
			      {"name" : "Phone"},
				  {"name" : "CellPhone"},
		          {"name" : "FixedPhone"}],
"value types" : [],
"links" : []
}
EOT;
		
		$strategy = new Meta2ORM();
		$strategy->create_modelKF($json);
		print_r($strategy->orm);
		$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
		
	}
		
	##
	# Test translation from metamodel object types and attributes to ORM entity types and data types.
	public function testMetamodelObjectTypeAttr2ORMDatatypes(){
		$json = <<< EOT
{
"Object type": [{"name":"PhoneCall"},
		    	{"name":"Phone"}],
"Subsumption" : [],
"Association" : [],
"Object type cardinality" : [],
"Attribute"   : [{"class name" : "PhoneCall", "attribute name" : "date", "datatype" : "String"},
				 {"class name" : "Phone", "attribute name" : "location", "datatype" : "String"},
				 {"class name" : "Phone", "attribute name" : "owner", "datatype" : "String"}]
}
EOT;

		$expected = <<< EOT
{
"entity types" : [{"name" : "PhoneCall"},
			      {"name" : "Phone"}],
"value types" :  [{"value type name" : "date", "datatype" : "String"},
				  {"value type name" : "location", "datatype" : "String"},
				  {"value type name" : "owner", "datatype" : "String"}],
"links" : [{"name" : "PhoneCalldate",
			"entity type" : ["PhoneCall", "date"],
			"multiplicity" : ["0..*","1..*"],
			"type" : "binary predicate"
		   },
		   {"name" : "Phonelocation",
			"entity type" : ["Phone", "location"],
			"multiplicity" : ["0..*","1..*"],
			"type" : "binary predicate"
		   },
		   {"name" : "Phoneowner",
			"entity type" : ["Phone", "owner"],
			"multiplicity" : ["0..*","1..*"],
			"type" : "binary predicate"
		   }	
		  ]
}
EOT;
		
			$strategy = new Meta2ORM();
			$strategy->create_modelKF($json);
			print_r($strategy->orm);
			$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
		
	}
	
		
	##
	# Test translation from metamodel object types and subsumptions to ORM entity types and subtypes.
	public function testMetamodelObjectTypeSub2ORMSubtypes(){
		$json = <<< EOT
{
"Object type": [{"name":"Phone"},
				{"name":"CellPhone"}],
"Subsumption" : [{"name" : "r1",
				  "parent" : "Phone",
			      "children" : ["CellPhone"]}],
"Association" : [],
"Object type cardinality" : [],
"Attribute"   : []
}
EOT;
		$expected = <<< EOT
{
"entity type" : [{"name" : "Phone"},
			     {"name" : "CellPhone"}],
"links" : [{"entity type" : ["CellPhone"],
			"multiplicity" : null,
			"name" : "r1",
			"type" : "subtype",
			"parent" : "Phone",
			"constraint" : []
		   }]
}
EOT;
		
		$strategy = new Meta2ORM();
		$strategy->create_modelKF($json);
		print_r($strategy->orm);
		$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
		
	}
		
		
	## ERD
	
	# Test translation from metamodel object types to EER entities.
		public function testMetamodelObjectType2EER(){
			$json = <<< EOT
{
"Object type": [{"name":"PhoneCall"},
		    	{"name":"Phone"},
				{"name":"CellPhone"},
				{"name":"FixedPhone"}],
"Subsumption" : [],
"Association" : [],
"Object type cardinality" : [],
"Attribute"   : []
}
EOT;
		
			$expected = <<< EOT
{
"entities" : [{"name" : "PhoneCall", "attrs" : []},
			  {"name" : "Phone", "attrs" : []},
			  {"name" : "CellPhone", "attrs" : []},
		      {"name" : "FixedPhone", "attrs" : []}],
"links" : []
}
EOT;
		
			$strategy = new Meta2EER();
			$strategy->create_modelKF($json);
			print_r($strategy->eer);
			$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
		
	}

	
	##
	# Test translation from metamodel object types to EER entities with attributes.
	public function testMetamodelObjectType2EERwithAttrs(){
		$json = <<< EOT
{
"Object type": [{"name":"PhoneCall"},
		    	{"name":"Phone"},
				{"name":"CellPhone"},
				{"name":"FixedPhone"}],
"Subsumption" : [],
"Association" : [],
"Object type cardinality" : [],
"Attribute"   : [{"class name" : "Phone", "attribute name" : "location", "datatype" : "String"},
				 {"class name" : "Phone", "attribute name" : "owner", "datatype" : "String"},
				 {"class name" : "PhoneCall", "attribute name" : "date", "datatype" : "String"}]
}
EOT;
	
		$expected = <<< EOT
{
"entities" : [{"name" : "PhoneCall", "attrs" : [{"name" : "date"}]},
			  {"name" : "Phone", "attrs" : [{"name" : "location"}, {"name" : "owner"}]},
			  {"name" : "CellPhone", "attrs" : []},
		      {"name" : "FixedPhone", "attrs" : []}],
"links" : []
}
EOT;
	
		$strategy = new Meta2EER();
		$strategy->create_modelKF($json);
		print_r($strategy->eer);
		$this->assertJsonStringEqualsJsonString($expected, $strategy->get_json(),true);
	
	}
	
}
