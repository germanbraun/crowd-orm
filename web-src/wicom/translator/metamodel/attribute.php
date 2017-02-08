<?php
/*

Copyright 2017

Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA) -
Facultad de Informática
Universidad Nacional del Comahue

attribute.php

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

namespace Wicom\Translator\Metamodel;
use function \load;
load('attributeproperty.php');


	class Attribute extends AttributeProperty{

		protected $objClassAttr = "";
		protected $objectAttrName = "";
		protected $objAttrDataType = "";
		
		/**
		 UML: attribute  
		 EER: attribute, but without including a data type in the diagram
		 ORM: absent (represented differently)
		 */
		
		function __construct($classname,$attrname,$datatype){
		
			$this->objClassAttr = $classname;
			$this->objectAttrName = $attrname;
			$this->objAttrDataType = $datatype;
		
		}
		
		function get_json_array(){
			return ["class name" => $this->objClassAttr,
					"attribute name" => $this->objectAttrName,
					"datatype" => $this->objAttrDataType,
			];
		
		}
		
		
		function transformationORM($metajson){
		
		
		}

	}

?>
