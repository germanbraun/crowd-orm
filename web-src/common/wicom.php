<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   wicom.php
   
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

namespace Wicom;

load("translator.php", "../wicom/translator/");
load("crowd_uml.php", "../wicom/translator/strategies/");
load("owllinkbuilder.php", "../wicom/translator/builders/");

load("runner.php", "../wicom/reasoner/");
load("racerconnector.php", "../wicom/reasoner/");
# load("owllinkanalizer.php", "../wicom/answers/");

use Wicom\Translator\Translator;
use Wicom\Translator\Strategies\UMLcrowd;
use Wicom\Translator\Builders\OWLlinkBuilder;

use Wicom\Reasoner\Runner;
use Wicom\Reasoner\RacerConnector;

# use Wicom\Answers\OWLlinkAnalizer;

class Wicom{
    function __construct(){
    }

    /**
       Check the diagram represented in JSON format for 
       satisfiability.
       
       @param $json_str A String with the diagram in JSON format.
       @return Wicom\Translator\Strategies\QAPackages\AnswerAnalizers\Answer an answer object.
     */
    function is_satisfiable($json_str){
        // Translate using a strategy
        $strategy = new UMLcrowd();
        $trans = new Translator($strategy, new OWLlinkBuilder());
        $owllink_str = $trans->to_owllink($json_str);

        // Execute the reasoner
        $runner = new Runner(new RacerConnector());
        $runner->run($owllink_str);
        $owllink_answer = $runner->get_last_answer();

        // Generate the answer.
        /*
          $owllink_analizer = new OWLlinkAnalizer($owllink_str, $owllink_answer);        
          $owllink_analizer->analize();        

          return $owllink_analizer->get_answer();
        */
        return $strategy->analize_answer($owllink_str, $owllink_answer);
    }
}

?>
