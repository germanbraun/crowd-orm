<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   translatortest.php
   
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
load("calvanessestrat.php", "wicom/translator/strategies/");
load("owllinkbuilder.php", "wicom/translator/builders/");
load("translator.php", "wicom/translator/");

use Wicom\Translator\Strategies\Calvanesse;
use Wicom\Translator\Builders\OWLlinkBuilder;
use Wicom\Translator\Translator;

class TranslatorTest extends PHPUnit_Framework_TestCase
{

    public function test_to_owlink(){
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
<IsKBSatisfiable kb=\"http://localhost/kb1\" />
<IsClassSatisfiable kb=\"http://localhost/kb1\">
  <owl:Class IRI=\"Hi World\" />
</IsClassSatisfiable>
</RequestMessage>";
        
        $strategy = new Calvanesse();
        $builder = new OWLlinkBuilder();
        $translator = new Translator($strategy, $builder);
    
        $actual = $translator->to_owllink($json);

        $expected = process_xmlspaces($expected);
        $actual = process_xmlspaces($actual);
        $this->assertEqualXMLStructure($expected, $actual, true);
    }

    public function test_JSON_to_OWLlink_with_users_owllink(){
        //TODO: Complete JSON!
        $json = '{"classes": [{"attrs":[], "methods":[], "name": "Hi World"}], "owllink": "<hiworld></hiworld>"}';
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
<IsKBSatisfiable kb=\"http://localhost/kb1\" />
<IsClassSatisfiable kb=\"http://localhost/kb1\">
  <owl:Class IRI=\"Hi World\" />
</IsClassSatisfiable>
<hiworld></hiworld>
</RequestMessage>";
        
        $strategy = new Calvanesse();
        $builder = new OWLlinkBuilder();
        $translator = new Translator($strategy, $builder);
    
        $actual = $translator->to_owllink($json);

        $expected = process_xmlspaces($expected);
        $actual = process_xmlspaces($actual);
        $this->assertEqualXMLStructure($expected, $actual, true);
    }
}

?>
