<?php
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   calvanessetest.php
   
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
load("calvanessestrat.php", "translator/strategies/");
load("owllinkbuilder.php", "translator/builders/");

use Wicom\Translator\Strategies\Calvanesse;
use Wicom\Translator\Builders\OWLlinkBuilder;

class CalvanesseTest extends PHPUnit_Framework_TestCase
{

    public function testTranslate(){
        //TODO: Complete JSON!
        $json = '{"classes": [{"attrs":[], "methods":[], "name": "Hi World"}]}';
        //TODO: Complete XML!
        $expected = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<RequestMessage xmlns=\"http://www.owllink.org/owllink#\"
xmlns:owl=\"http://www.w3.org/2002/07/owl#\" 
xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
xsi:schemaLocation=\"http://www.owllink.org/owllink# 
http://www.owllink.org/owllink-20091116.xsd\">
       <CreateKB kb=\"http://localhost/kb1\" />
       <Tell kb=\"http://localhost/kb1\">   
       <owl:SubClassOf>
       <owl:Class IRI=\"Hi World\" />
       <owl:Class abbreviatedIRI=\"owl:Thing\" />
       </owl:SubClassOf>
       </Tell>
</RequestMessage>";
        
        $strategy = new Calvanesse();
        $builder = new OWLlinkBuilder();

        $builder->insert_header(); // Without this, loading the DOMDocument
        // will throw error for the owl namespace
        $strategy->translate($json, $builder);
        $builder->insert_footer();
        
        $actual = $builder->get_product();
        $actual = $actual->to_string();

        $expected = process_xmlspaces($expected);
        $actual = process_xmlspaces($actual);
        $this->assertEqualXMLStructure($expected, $actual, true);
    }

    ##
    # Test if translate works properly with binary roles.    
    public function testTranslateBinaryRoles(){
        //TODO: Complete JSON!
        $json = <<<'EOT'
{"classes": [
    {"attrs":[], "methods":[], "name": "Person"},
    {"attrs":[], "methods":[], "name": "Cellphones"}],
 links: [
     {classes: ["Person", "Cellphones"],
      multiplicity: ["1..1", "1..*"],
      name: "hasCellphone",
      type: "association"}
	]
}
EOT;
        //TODO: Complete XML!
        $expected = <<<'EOT'
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<RequestMessage xmlns=\"http://www.owllink.org/owllink#\"
		xmlns:owl=\"http://www.w3.org/2002/07/owl#\" 
		xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
		xsi:schemaLocation=\"http://www.owllink.org/owllink# 
				    http://www.owllink.org/owllink-20091116.xsd\">
  <CreateKB kb=\"http://localhost/kb1\" />
  <Tell kb=\"http://localhost/kb1\">
    <!-- <owl:ClassAssertion>
      <owl:Class IRI=\"Person\" />
      <owl:NamedIndividual IRI=\"Mary\" />
      </owl:ClassAssertion>
      -->
    
    <owl:SubClassOf>
      <owl:Class IRI=\"Person\" />
      <owl:Class abbreviatedIRI=\"owl:Thing\" />
    </owl:SubClassOf>
    <owl:SubClassOf>
      <owl:Class IRI=\"Cellphone\" />
      <owl:Class abbreviatedIRI=\"owl:Thing\" />
    </owl:SubClassOf>
    <!-- One person can has lots of cellphones -->

    <owl:SubClassOf>
	<owl:ObjectSomeValuesFrom>
	    <owl:ObjectProperty IRI=\"hasCellphone\" />
	    <owl:Class abbreviatedIRI=\"owl:Thing\" />
	</owl:ObjectSomeValuesFrom>
	<owl:Class IRI=\"Person\" />
    </owl:SubClassOf>
   
    <owl:SubClassOf>
	<owl:ObjectSomeValuesFrom>
	    <owl:ObjectInverseOf>
		<owl:ObjectProperty IRI=\"hasCellphone\" />
	    </owl:ObjectInverseOf>
	    <owl:Class abbreviatedIRI=\"owl:Thing\" />
	</owl:ObjectSomeValuesFrom>
	<owl:Class IRI=\"Cellphone\" />
    </owl:SubClassOf>

    <owl:SubClassOf>
	<owl:Class IRI=\"Person\" />
	<owl:ObjectMinCardinality cardinality=\"1\">
	    <owl:ObjectProperty IRI=\"hasCellphone\" />
	</owl:ObjectMinCardinality>
    </owl:SubClassOf>

    <owl:SubClassOf>
	<owl:Class IRI=\"Cellphone\" />
	<owl:ObjectIntersectionOf>
	    <owl:ObjectMinCardinality cardinality=\"1\">
		<owl:ObjectInverseOf>
		    <owl:ObjectProperty IRI=\"hasCellphone\" />
		</owl:ObjectInverseOf>
	    </owl:ObjectMinCardinality>
	    <owl:ObjectMaxCardinality cardinality=\"1\">
		<owl:ObjectInverseOf>
		    <owl:ObjectProperty IRI=\"hasCellphone\" />
		</owl:ObjectInverseOf>
	    </owl:ObjectMaxCardinality>
	</owl:ObjectIntersectionOf>
    </owl:SubClassOf>

  </Tell>
  <!-- <ReleaseKB kb=\"http://localhost/kb1\" /> -->
</RequestMessage>
EOT;
        
        $strategy = new Calvanesse();
        $builder = new OWLlinkBuilder();

        $builder->insert_header(); // Without this, loading the DOMDocument
        // will throw error for the owl namespace
        $strategy->translate($json, $builder);
        $builder->insert_footer();
        
        $actual = $builder->get_product();
        $actual = $actual->to_string();

        $expected = process_xmlspaces($expected);
        $actual = process_xmlspaces($actual);
        $this->assertEqualXMLStructure($expected, $actual, true);
    }
}
