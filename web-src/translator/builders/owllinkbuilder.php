<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   OWLlinkBuilder.php
   
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

namespace Wicom\Translator\Builders;

use function \load;
load("documentbuilder.php");
load("owllinkdocument.php", "../documents/");

use Wicom\Translator\Documents\OWLlinkDocument;

class OWLlinkBuilder extends DocumentBuilder{
    function __construct(){
        $this->product = new OWLlinkDocument;
    }
    
    public function insert_header($createkb=true, $starttell=true){
        $this->product->start_document();
        if ($createkb){
            $this->product->insert_create_kb("http://localhost/kb1");
        }
        if ($starttell){
            $this->product->start_tell();
        }
    }

    public function insert_class($name, $col_attrs = []){
        $this->product->insert_class($name);
    }

    public function insert_subclassof($child, $father){
        $this->product->insert_subclassof($child, $father);
    }

    protected function ensure_end_tell(){
        $this->product->end_tell();
    }
    
    /**
       @name Queries
    */
    ///@{

    /**
       Insert "is diagram/KB satisfiable" query.
     */
    public function insert_satisfiable(){
        $this->ensure_end_tell();
        $this->product->insert_satisfiable();
    }

    public function insert_satisfiable_class($classname){
        $this->ensure_end_tell();
        $this->product->insert_satisfiable_class($classname);
    }

    ///@}
    // Queries

    public function insert_footer(){
        $this->product->end_tell();
        $this->product->end_document();
    }

    /**
       Reimplementation because we have to finish the product 
       before getting it.
     */
    public function get_product($finish=false){
        if ($finish){
            $this->product->end_document();
        }
        return $this->product;
    }

    /**
       @name DL list translation
    */
    ///@{
    public function translate_DL($DL_list){
        foreach ($DL_list as $elt){
            $this->DL_element($elt);
        }
    }

    protected function DL_element($elt){
        if (! \is_array($elt)){
            // Is not an array! something wrong has been passed!
            throw new \Exception("DL_element receives only hashed arrays, 
check your Descriptive Logic array if is correctly formatted. 
You passed a " . gettype($elt) . " on: " . print_r($elt, true) );
        }
        
        $key = array_keys($elt)[0];

        switch ($key){
        case "class" :
            $this->product->insert_class($elt["class"]);
            break;
        case "role" :
            $this->product->insert_objectproperty($elt["role"]);
            break;
        case "subclass" :
            $this->product->begin_subclassof();
            // We expect various consecutives DL cexpressions 
            // (two classes for example)
            $this->translate_DL($elt["subclass"]);
            $this->product->end_subclassof();
            break;
        case "intersection" :
            $this->product->begin_intersectionof();
            $this->translate_DL($elt["intersection"]);
            $this->product->end_intersectionof();
            break;
        case "inverse" :
            $this->product->begin_inverseof();
            // We expect one DL expression
            // (the inverse of the inverse of the role for example,
            // but not one role, and one inverse of another role).
            $this->DL_element($elt["inverse"]);
            $this->product->end_inverseof();
            break;
        case "exists" :
            $this->product->begin_somevaluesfrom();
            $this->DL_element($elt["exists"]);
            $this->product->insert_class("owl:Thing");
            $this->product->end_somevaluesfrom();
            break;
        case "mincard" :
            $this->product->begin_mincardinality($elt["mincard"][0]);
            $this->DL_element($elt["mincard"][1]);
            $this->product->end_mincardinality();
            break;
        case "maxcard" :
            $this->product->begin_maxcardinality($elt["maxcard"][0]);
            $this->DL_element($elt["maxcard"][1]);
            $this->product->end_maxcardinality();
            break;
        default:
            throw new \Exception("I don't know $key DL operand");
        }
    }
    ///@}
    // DL List Translation
}
?>
