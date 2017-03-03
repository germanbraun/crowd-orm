<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   owlbuilder.php
   
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
load("owldocument.php", "../documents/");

use Wicom\Translator\Documents\OWLDocument;

class OWLBuilder extends DocumentBuilder{
    function __construct(){
        $this->product = new OWLDocument;
        $this->min_max = [];
    }
    
    public function insert_header($createkb=true, $starttell=true){
        $this->product->start_document();
    }

    public function insert_class($name, $col_attrs = []){
        $this->product->insert_class($name);
    }

    public function insert_subclassof($child, $father){
        $this->product->insert_subclassof($child, $father);
    }   

    public function insert_footer(){
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
    ///@}
    // DL List Translation
}
?>
