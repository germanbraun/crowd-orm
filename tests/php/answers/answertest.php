<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   testAnswer.php
   
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
load("answer.php", "answers/");

use Wicom\Answers\Answer;

class AnswerTest extends PHPUnit_Framework_TestCase
{

    public function testAnswerJson(){
        $expected = <<<EOT
       { 
           "satisfiable": {
               "kb" : true,
               "classes" : ["name1", "name2"]
           },
           "unsatisfiable": {
              	"classes" : ["name3", "name4"]
           },
           "suggestions" : {
              	"links" : [
              	    {"name" : "suggestion 1",
              	     "classes": ["classname 1", "classname 2"]}
              	]
           },
           "reasoner" : {
              	"input" : "STRING WITH REASONER INPUT",
              	"output" : "STRING WITH REASONER OUTPUT"
           }
       }
EOT;

        $answer = new Answer();
        $answer->set_kb_satis(true);
        $answer->add_satis_class("name1");
        $answer->add_satis_class("name2");
        $answer->add_unsatis_class("name3");
        $answer->add_unsatis_class("name4");
        $answer->add_link_sugges("suggestion 1", ["classname 1", "classname 2"]);
        $answer->set_reasoner_input("STRING WITH REASONER INPUT");
        $answer->set_reasoner_output("STRING WITH REASONER OUTPUT");

        $actual = $answer->to_json();
        
        $this->assertJsonStringEqualsJsonString($expected, $actual, true);
    }
}




