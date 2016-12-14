<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   documentbuilder.php
   
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

/**
   I set the common behaviour for every DocumentBuilder subclass.

   @abstract
 */
abstract class DocumentBuilder{
    protected $product = null;
    
    abstract public function insert_header();
    abstract public function insert_class($name, $col_attrs = []);
    /**
       Depending on the subclass, add an OWLlink text directly. 
     */
    public function insert_owllink($text){
    }
    
    abstract public function insert_footer();

    abstract public function insert_satisfiable();
    abstract public function insert_satisfiable_class($classname);
    

    /**
       Return the product builded.

       @return A Wicom\Translator\Documents\Document subclass instance.
     */
    public function get_product(){
        return $this->product;
    }

    /**
       @name DL List Translation
       
       A DL List is a list of Description Logic operands and parameters in 
       preorder form. There are some declaration supported, more can be added 
       as much as needed in the DL_element() function.

       The first element of the list declares the operation or the type of the
       element is representing, a class or a role. 

       ```php
       ['class' => $classname]
       ['role' => $rolename]
       ['subclass' => [$class_or_expression1, $class_or_expression2, $others]]
       ['exists' => $role]
       ['inverse' => $class_or_expression]
       ['mincard' => [$number, $role]]
       ['maxcard' => [$number, $role]]
       ['intersection' => [$class_or_expression1,$class_or_expression2, $others]]
       ```
    */
    ///@{
    public function translate_DL($DL_list){

//		print_r($DL_list);
        foreach ($DL_list as $elt){
//			print_r($elt);
            $this->DL_element($elt);
        }
    }

    /**
       I translate a single element of the DL List.

       # Overriding 
       Use `$this->product` for referencing the product being built. Also, you 
       can call the function translate_DL() for translating a subexpression.

       @param $elt  A List element.
     */
    protected function DL_element($elt){
        if (! \is_array($elt)){
            // Is not an array! something wrong has been passed!
            throw new \Exception("DL_element receives only hashed arrays, 
check your Descriptive Logic array if is correctly formatted. 
You passed a " . gettype($elt) . " on: " . print_r($elt, true) );
        }

       // print_r($elt);
        $key = array_keys($elt)[0];

//		print_r($key);

        switch ($key){
        case "class" :
            $this->product->insert_class($elt["class"]);
            break;
        case "role" :
            $this->product->insert_objectproperty($elt["role"]);
            break;
        case "subclass" :
            $this->product->begin_subclassof();
            $this->translate_DL($elt["subclass"]);
            $this->product->end_subclassof();
            break;
        case "intersection" :
            $this->product->begin_intersectionof();
            $this->translate_DL($elt["intersection"]);
            $this->product->end_intersectionof();
            break;
        case "union" :
            $this->product->begin_unionof();
            $this->translate_DL($elt["union"]);
            $this->product->end_unionof();
            break;
        case "complement" :
            $this->product->begin_complementof();
            $this->DL_element($elt["complement"]);
            $this->product->end_complementof();
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
        case "forall" :
            $this->product->begin_allvaluesfrom();
            $this->DL_element($elt["forall"][0]);
            $this->DL_element($elt["forall"][1]);
            $this->product->end_allvaluesfrom();
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
		case "domain" :
			$this->product->begin_objectpropertydomain();
			$this->DL_element($elt["domain"][0]);
			$this->DL_element($elt["domain"][1]);
			$this->product->end_objectpropertydomain();
			break;
		case "range" :
			$this->product->begin_objectpropertyrange();
			$this->DL_element($elt["range"][0]);
			$this->DL_element($elt["range"][1]);
			$this->product->end_objectpropertyrange();
			break;
		case "equivalentclasses" :
			$this->product->begin_equivalentclasses();
			$this->translate_DL($elt["equivalentclasses"]);
			$this->product->end_equivalentclasses();
			break;
        default:
            throw new \Exception("I don't know $key DL operand");
        }
    }

    ///@}
    // DL List Translation
}
?>
