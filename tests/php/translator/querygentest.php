<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   querygentest.php
   
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

//use function \load;
load("owllinkdocument.php", "wicom/translator/documents/");
load("owllinkbuilder.php", "wicom/translator/builders/");
load("queriesgenerator.php", "wicom/querying/queries/");

use Wicom\Translator\Documents\OWLlinkDocument;
use Wicom\Translator\Builders\OWLlinkBuilder;
use Wicom\QueriesGen\QueriesGenerator;

class QueryGenTest extends PHPUnit_Framework_TestCase{
    public function testInsertIsSatisfiable(){
        $expected = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<RequestMessage xmlns=\"http://www.owllink.org/owllink#\"
		xmlns:owl=\"http://www.w3.org/2002/07/owl#\" 
		xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
		xsi:schemaLocation=\"http://www.owllink.org/owllink# 
				    http://www.owllink.org/owllink-20091116.xsd\">
  <IsKBSatisfiable kb=\"http://localhost/kb1\" />
</RequestMessage>";
        
        $doc = new OWLlinkDocument();
        $doc->set_actual_kb("http://localhost/kb1");
        $doc->start_document();
        $doc->insert_satisfiable();
        $doc->end_document();

        $actual = process_xmlspaces($doc->to_string());
        $expected = process_xmlspaces($expected);
        $this->assertEqualXMLStructure($expected, $actual, true);
    }
    
    public function testInsertIsSatisfiableClass(){
        $expected = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<RequestMessage xmlns=\"http://www.owllink.org/owllink#\"
		xmlns:owl=\"http://www.w3.org/2002/07/owl#\" 
		xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
		xsi:schemaLocation=\"http://www.owllink.org/owllink# 
				    http://www.owllink.org/owllink-20091116.xsd\">
  <IsKBSatisfiable kb=\"http://localhost/kb1\" />
  <IsClassSatisfiable kb=\"http://localhost/kb1\">
    <owl:Class IRI=\"Person\" />
  </IsClassSatisfiable>
</RequestMessage>";
        
        $doc = new OWLlinkDocument();
        $doc->set_actual_kb("http://localhost/kb1");
        $doc->start_document();
        $doc->insert_satisfiable();
        $doc->insert_satisfiable_class("Person");
        $doc->end_document();

        $actual = process_xmlspaces($doc->to_string());
        $expected = process_xmlspaces($expected);
        $this->assertEqualXMLStructure($expected, $actual, true);
    }

    public function testQueriesClass(){
        $expected = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<RequestMessage xmlns=\"http://www.owllink.org/owllink#\"
		xmlns:owl=\"http://www.w3.org/2002/07/owl#\" 
		xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
		xsi:schemaLocation=\"http://www.owllink.org/owllink# 
				    http://www.owllink.org/owllink-20091116.xsd\">
  <CreateKB kb=\"http://localhost/kb1\" />
  <IsKBSatisfiable kb=\"http://localhost/kb1\" />
  <IsClassSatisfiable kb=\"http://localhost/kb1\">
    <owl:Class IRI=\"Person\" />
  </IsClassSatisfiable>
  <IsClassSatisfiable kb=\"http://localhost/kb1\">
    <owl:Class IRI=\"Student\" />
  </IsClassSatisfiable>
  <IsClassSatisfiable kb=\"http://localhost/kb1\">
    <owl:Class IRI=\"Misc\" />
  </IsClassSatisfiable>
</RequestMessage>";

        $json = '{"classes": [{"name":"Person"}, {"name":"student"}, {"name":"misc"}]}';
        
        $builder = new OWLlinkBuilder();
        $gen  = new QueriesGenerator();

        $builder->insert_header(true,false);
        $gen->gen_satisfiable($builder);
        $gen->gen_class_satisfiable($json, $builder);
        $builder->insert_footer();
        
        $doc = $builder->get_product();
            
        $actual = process_xmlspaces($doc->to_string());
        $expected = process_xmlspaces($expected);
        $this->assertEqualXMLStructure($expected, $actual, true);
    }
}

?>
