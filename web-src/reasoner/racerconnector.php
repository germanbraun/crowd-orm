<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   racerconnector.php
   
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

namespace Wicom\Reasoner;

load("connector.php");

use Wicom\Reasoner\Connector;

class RacerConnector extends Connector{


    //TODO: Change PROGRAM_CMD and FILES_PATH into configuration variables.
    
    /**
       The Racer command to execute.
     */
    const PROGRAM_CMD = "/home/wicom/racer/Racer -- -owllink";
    
    /**
       Here we store some temporary files for executing with Racer.
     */
    const FILES_PATH = "/home/wicom/racer/";
    
    /**
       Execute Racer with the given $document as input.
     */
    function run($input_string){
        $owllink_file = fopen(RacerConnector::FILES_PATH . "input-file.owllink", "w");
        fwrite($owllink_file, $input_string);
        fclose($owllink_file);
        
        exec(
            RacerConnector::PROGRAM_CMD . " " . RacerConnector::FILES_PATH . "input-file.owllink",
            $answer);
        array_push($this->col_answers, join($answer));
    }
}

?>
