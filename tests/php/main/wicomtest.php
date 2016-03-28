<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   wicomtest.php
   
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
load("wicom.php", "common/");
load("config.php", "config/");

use Wicom\Wicom;

class WicomTest extends PHPUnit_Framework_TestCase
{
    public function test_is_satisfiable(){
        $input = '{"classes": [{"attrs":[], "methods":[], "name": "Hi World"}]}';
        $expected = <<<EOT
       { 
           "satisfiable": {
               "kb" : true,
               "classes" : ["Hi World"]
           },
           "unsatisfiable": {
              	"classes" : []
           },
           "suggestions" : {
              	"links" : []
           },
           "reasoner" : {
              	"input" : "",
              	"output" : ""
           }
       }
EOT;


        $wicom = new Wicom();
        // $GLOBALS['config']['temporal_path'] = "../../temp/";
        $answer = $wicom->is_satisfiable($input);

        print("\n\$answer = ");
        print_r($answer);
        print("\n");        
        
        $answer->set_reasoner_input("");
        $answer->set_reasoner_output("");
        $actual = $answer->to_json();

        $this->assertJsonStringEqualsJsonString($expected, $actual, true);
    }    
}