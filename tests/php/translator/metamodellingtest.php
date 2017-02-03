<?php
/* 

   Copyright 2016 Gilia, Departamento de Teoría de la Computación, Universidad Nacional del Comahue
   
   Author: Gilia  

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

use Wicom\Translator\Metastrategies\UMLMeta;




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
	# General Test 
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
	
}
