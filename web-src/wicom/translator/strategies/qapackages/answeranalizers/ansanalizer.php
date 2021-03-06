<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   ansanalizer.php
   
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

/**
   Namespace for Answers analizers. 

   This analizers process the reasoner output and generate a JSON as
   follows:

 */
namespace Wicom\Translator\Strategies\QAPackages\AnswerAnalizers;

use function \load;
load("answer.php");
    

/**
   Analize the reasoner answer.

   You need to create an instance and provide the reasoner query and its response using generate_answer(). Then you can ask for analize() all.

   @code{php}
   $ans = new AnsAnalizer();
   $ans->generate_answer($reasoner_query, $reasoner_answer);
   $ans->analize()
   @endcode
   
 */
abstract class AnsAnalizer{

    /**
       An instance of Wicom\Answers\Answer.
       
       The answer created with analize().
     */
    protected $answer = null;

    /**
       Please, call generate_answer() for start to process the reasoner query and its response.
     */
    function __construct(){
    }

    /**
       Generate an empty Answer instance available before analizing.

       @param query The input query String given to the reasoner.
       @param answer The output given by the reasoner.
    */
    function generate_answer($query, $answer){
        $this->answer = new Answer();
        $this->answer->set_reasoner_input($query);
        $this->answer->set_reasoner_output($answer);
    }

    /**
       Do the last task and return the Answer instance. 

       Ensure to call generate_answer() and analize() before.
     */
    function get_answer(){
        return $this->answer;
    }

    /**
       Analize and create the answer.

       **Implements in the subclass**

       Set the $answer attribute. 
     */
    abstract function analize();
}
