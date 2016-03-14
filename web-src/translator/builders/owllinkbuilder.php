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
    
    public function insert_header(){
        $this->product->insert_create_kb("http://localhost/kb1");
        $this->product->start_tell();
    }

    public function insert_class($name, $col_attrs = []){
        $this->product->insert_class($name);
    }

    public function insert_subclassof($child, $father){
        $ns_regexp = '/.*:.*/';        // Namespace Regexp.
        $child_abbrv = false;
        $father_abbrv = false;
        
        if (preg_match($ns_regexp, $child) > 0){
            $child_abbrv = true;
        }
        if (preg_match($ns_regexp, $father) > 0){
            $father_abbrv = true;
        }
	
        $this->product->insert_subclassof($child, $father, $child_abbrv, $father_abbrv);
    }

    /**
       @name Queries
    */
    ///@{

    /**
       Insert "is diagram/KB satisfiable" query.
     */
    public function insert_satisfiable(){
        $this->product->insert_satisfiable();
    }

    public function insert_satisfiable_class($classname){
        $this->product->insert_satisfiable_class($classname);
    }

    ///@}
    // Queries

    public function insert_footer(){
        $this->product->end_tell();
        $this->product->end_document();
    }
}
?>
