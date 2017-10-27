<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   koncludeconnector.php
   
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
load("config.php", "../../config/");

use Wicom\Reasoner\Connector;

class KoncludeConnector extends Connector{


    //TODO: Change PROGRAM_CMD and FILES_PATH into configuration variables.
    
    /**
       The Konclude command to execute with all its parameters.
     */
//    const PROGRAM_CMD = "Racer";
//    const PROGRAM_PARAMS = "-- -silent -owllink ";
      
    const PROGRAM_CMD = "Konclude";
    const PROGRAM_PARAMS = " owllinkfile -i ";

    /**
       Execute Konclude with the given $document as input.
     */
    function run($input_string){
        $temporal_path = $GLOBALS['config']['temporal_path'];
        $konclude_path = $GLOBALS['config']['konclude_path'];

        /*
        print("\n\nWriting on $temporal_path/input-file.owllink\n");
        print("Directory Realpath: \"" . realpath($temporal_path) . "\" ");
        print("if blank, then path doesn't exists!\n\n");
        */
        
        $temporal_path = realpath($temporal_path) . "/";
        $file_path = $temporal_path . "input-file.owllink";
        $konclude_path .= KoncludeConnector::PROGRAM_CMD;
        $commandline = $konclude_path . " " . KoncludeConnector::PROGRAM_PARAMS . $file_path;

        $this->check_files($temporal_path, $konclude_path, $file_path);
        
        $owllink_file = fopen($file_path, "w");
        
        if (! $owllink_file){
            throw new \Exception("Temporal file couldn't be opened for writing...
Is the path '$file_path' correct?");
        }
        
        fwrite($owllink_file, $input_string);
        fclose($owllink_file);            
        
        exec($commandline,$answer );
        
        array_push($this->col_answers, join($answer));
    }

    /**
       Check for program and input file existance and proper permissions.

       @return true always
       @exception Exception with proper message if any problem is founded.
    */
    function check_files($temporal_path, $konclude_path, $file_path){
        if (! is_dir($temporal_path)){
            throw new \Exception("Temporal path desn't exists!
Are you sure about this path? 
temporal_path = \"$temporal_path\"");
        }

        if (!file_exists($file_path)){
            throw new \Exception("Temporal file doesn't exists, please create one at '$file_path'.");
        }

        if (!is_readable($file_path)){
            throw new \Exception("Temporal file cannot be readed.
Please set the write and read permissions for '$file_path'");
        }
        
        if (file_exists($file_path) and !is_writable($file_path)){
            throw new \Exception("Temporal file is not writable, please change the permissions.
Check the permissions on '${file_path}'.");
        }
        
        if (!file_exists($konclude_path)){
            throw new \Exception("The Konclude program has not been founded...
You told me that '$konclude_path' is the Konclude program, is this right? check your 'web-src/config/config.php' configuration file.");
        }
        
        if (!is_executable($konclude_path)){
            throw new \Exception("The Konclude program is not executable... 
Is the path '$konclude_path' right? Is the permissions setted properly?");
        }

        return true;
    }
}
?>
