<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   owllinkanalizer.php
   
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

namespace Wicom\Answers;

load("answer.php");
load("ansanalizer.php");

use Wicom\Answers\Answer;
use Wicom\Answers\AnsAnalizer;
use \XMLReader;

class OWLlinkAnalizer extends AnsAnalizer{

    /**
       XMLReader instance for parsing the query given to the 
       reasoner.
     */
    protected $query_reader = null;
    /**
       XMLReader instance for parsing the reasoner answer.
     */
    protected $answer_reader = null;

    /**
       Map between Queries and propper correct answers.
     */
    const ANSWERS_MAP = [
        "CreateKB" => "KB",
        "Tell" => "OK",
        "IsKBSatisfiable" => "BooleanResponse"
    ];
    
    function __construct($query, $answer){
        parent::__construct($query, $answer);
        
        $this->query_reader = XMLReader::xml($query);
        $this->answer_reader = XMLReader::xml($answer);
    }

    function analize(){
        $this->query_reader->next();
        $this->answer_reader->next();
        $this->query_reader->read();
        $this->answer_reader->read();
        while ($this->query_reader->next()){
            
            // Ignore spaces, comments, or whatever thing except an ELEMENT
            while ($this->query_reader->nodeType != XMLReader::ELEMENT){
                if (! $this->query_reader->next()){
                    return;
                }
            }
            // Next answer_reader element:
            if (! $this->answer_reader->next()){
                return;
            }
            // Ignore spaces, comments or whatever thing appears except an ELEMENT.
            while ($this->answer_reader->nodeType != XMLReader::ELEMENT){
                if (! $this->answer_reader->next()) {
                    return;
                }
            }

            /*
            print("\n\n--------------------");
            print($this->query_reader->name);
            print(" -> ");
            print($this->answer_reader->name);
            */            
            
            $q_tagname = $this->query_reader->name;
            
            // ...Checking for proper queries...
            
            if ($q_tagname == "IsKBSatisfiable"){
                // <BooleanResponse result="true" />
                $isit = $this->answer_reader->getAttribute("result");
                
                if ($isit == "true"){
                    $this->answer->set_kb_satis(true);
                }else{
                    $this->answer->set_kb_satis(false);
                }
            }

            if ($q_tagname == "IsClassSatisfiable"){
                /* In Query:
                       <IsClassSatisfiable kb="KB URI">
                           <owl:Class URI="URI OR CLASS NAME" />
                       </IsClassSatisfiable>

                   In Answer: <BooleanResponse result="true" />
                */
                
                // Get classname
                while ($this->query_reader->read() and
                       $this->query_reader->nodeType != XMLReader::ELEMENT){}
                    
                $classname = $this->query_reader->getAttribute("IRI");
                
                // Get results
                $isit = $this->answer_reader->getAttribute("result");

                if ($isit == "true"){
                    $this->answer->add_satis_class($classname);
                }else{
                    $this->answer->add_unsatis_class($classname);
                }
            }
            
            
        }
    }
}

