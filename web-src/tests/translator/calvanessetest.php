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
        $a = json_decode('{"clases": [{"attrs":[], "methods":[], "name": "Hola Mundo"}]}');
        //TODO: Complete XML!
        $xml = "";

        $t = new Translator(new Calvanesse(), new XMLOwlBuilder());
        $res = $t->translate($a);

        
        $this->assertEquals($xml $res);
    }
}