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

class CalvanesseTest extends PHPUnit_Framework_TestCase
{

    public function testTranslate(){
        //TODO: Complete JSON!
        $a = json_decode('{"clases": [{"attrs":[], "methods":[], "name": "Hi World"}]}');
        //TODO: Complete XML!
        $xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
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
  <ReleaseKB kb=\"http://localhost/kb1\" />
</RequestMessage>";

        $t = new Translator(new Calvanesse(), new XMLOwlBuilder());
        $res = $t->translate($a);

        
        $this->assertEquals($xml $res);
    }
}