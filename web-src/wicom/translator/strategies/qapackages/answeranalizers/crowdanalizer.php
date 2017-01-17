<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   crowdanalizer.php
   
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

namespace Wicom\Translator\Strategies\QAPackages\AnswerAnalizers;

load("answer.php");
load("ansanalizer.php");

use Wicom\Translator\Strategies\QAPackages\AnswerAnalizers\Answer;
use Wicom\Translator\Strategies\QAPackages\AnswerAnalizers\AnsAnalizer;
use \XMLReader;

class CrowdAnalizer extends AnsAnalizer{

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

       Used for filtering XML tags to the ones we care.
     */
    const ANSWERS_MAP = [
        "IsKBSatisfiable" => "BooleanResponse",
        "IsClassSatisfiable" => "BooleanResponse"
    ];
    
    function generate_answer($query, $answer){
        parent::generate_answer($query, $answer);

        $this->query_reader = XMLReader::xml($query);
        $this->answer_reader = XMLReader::xml($answer);
    }

    /**
       Remove comments and other tags, and create an array with 
       the most important tags and its answer.
       
       @return An Asociated Array with most important tags and 
       its answer. Example:

       @code{.php}
       [
         "IsKBSatisfiable" => "true", 
         "IsClassSatisfiable" => "true"
       ]       
       @endcode
     */
    function filter_xml(){
        $cont = true;
        $col = [
            "IsKBSatisfiable" => "false",
            "IsClassSatisfiable" => []
        ];
        
        // Enter the first tag
        $this->next_tag();
        $this->next_tag(false);
        $this->query_reader->read();
        $this->answer_reader->read();

        while ($this->next_important_tag()){
            if (! $this->next_important_tag(false)){
                return $col;
            }

            $a_name = $this->answer_reader->name;
            $q_name = $this->query_reader->name;
            
            if ($a_name == "BooleanResponse") {
                $isit = $this->answer_reader->getAttribute("result");

                if ($q_name == "IsClassSatisfiable"){
                    $classname = $this->find_classname();                    
                    array_push($col[$q_name], [$isit, $classname]);
                }else{  // $q_name == "IsKBSatisfiable"              
                    $col[$q_name] = $isit;
                }
            }
        }
        
        return $col;
    }

    protected function find_classname(){
        $this->query_reader->read();
        while ($this->query_reader->name != "owl:Class"){
            if (! $this->next_tag()){
                return false;
            }
        }

        $classname = $this->query_reader->getAttribute("IRI");
        
        return $classname;
    }

    /**
       Simply, go to the next initial tag.

       @param in_query A boolean, if true advance the query_reader,
       if false, advance the answer_reader.

       @return false if the EOF has been reached.
     */
    protected function next_tag($in_query = true){
        $cont = true;        
        if ($in_query){
            $xml = $this->query_reader;
        }else{
            $xml = $this->answer_reader;
        }
        
        while ($cont){
            try{
                if (!$xml->next()){
                    return false;
                }
            }catch(Exception $e){                
                return false;
            }
            $cont = $xml->nodeType != XMLReader::ELEMENT;
        }
        return true;
    }

    /**
       @param in_query A Boolean indicating if it must advance the 
       $this->query_reader XMLReader instance (true) or the 
       $this->answer_reader one (false).

       @return false if the EOF has been reached. True otherwise.
     */
    protected function next_important_tag($in_query=true){
        $cont = true;

        if ($in_query){
            $xml = $this->query_reader;
        }else{
            $xml = $this->answer_reader;
        }            
        
        while ($cont){
            if (! $xml->next()){
                // Cannot read more, EOF?
                return false;
            }

            // If it is not an ELEMENT, repeat.
            $cont = $xml->nodeType != XMLReader::ELEMENT;

            // If it has not the tagname we're looking for, repeat.
            if (!$cont){
                // It is in fact an element.
                if($in_query){
                    $cont = ! array_key_exists($xml->name,
                                               CrowdAnalizer::ANSWERS_MAP);
                }else{
                    $cont = ! array_search($xml->name,
                                           CrowdAnalizer::ANSWERS_MAP);
                }
            }
        }
        
        return true;
    }
    

    
    function analize(){

        /*
        print("\n\n ________________________________________\n");
        print("analize() ---------->\n\n");
        print_r($this->answer);
        */
        
        $col = $this->filter_xml();

        //print_r($col);

        
        $val = $col["IsKBSatisfiable"];
        $this->answer->set_kb_satis($val == "true");                    

        $col_class = $col["IsClassSatisfiable"];
        foreach ($col_class as $val){
            if ($val[0] == "true"){
                $this->answer->add_satis_class($val[1]);
            }else{
                $this->answer->add_unsatis_class($val[1]);
            }        
        }
        return $this->answer;
    }                    
    
}

