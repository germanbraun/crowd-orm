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
        $this->min_max = [];
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

    /**
       @todo Move this into the Strategy.
    */
    public function insert_class_min($classname, $minname){
        if (key_exists($classname, $this->min_max)){
            $this->min_max[$classname][0] = $minname;
        }else{
            $this->min_max[$classname] = [$minname, null];
        }
        $this->product->insert_class($minname);
    }

    /**
       @todo Move this into the Strategy.
     */
    public function insert_class_max($classname, $maxname){
        if (key_exists($classname, $this->min_max)){
            $this->min_max[$classname][1] = $maxname;
        }else{
            $this->min_max[$classname] = [null, $maxname];
        }
            
        $this->product->insert_class($maxname);
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

    /**
       Insert an entail OWLlink query for checking equivalence between classes.

       @param $array An array of class names.
     */
    public function insert_equivalent_class_query($array){
        $this->ensure_end_tell();
        $this->product->insert_equivalent_class_query($array);
    }

    ///@}
    // Queries

    public function insert_owllink($text){
        $this->ensure_end_tell();
        $this->product->insert_owllink($text);
    }

    public function insert_footer(){
        $this->product->end_tell();
        $this->product->end_document();
    }

    /**
       Retrieve the classes with its min and max if its exists.

       @return A hash like ["classname" => ["min_class_name", "max_class_name"]]
       @todo Move this into the Strategy.
     */
    public function get_classes_with_min_max(){
        return $this->min_max;
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
    ///@}
    // DL List Translation
}
?>
