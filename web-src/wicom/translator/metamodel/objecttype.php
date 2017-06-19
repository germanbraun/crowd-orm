<?php
/*

Copyright 2017

Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA) -
Facultad de Informática
Universidad Nacional del Comahue

objecttype.php

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
load('entitytype.php');


	class ObjectType extends EntityType{
		
		protected $objectTypeName = ""; 
		
		/**
		 UML: class 
		 EER: entity type 
		 ORM: non-lexical object type / entity type
			for Object subtype, there is the naming, respectively:
				subclass (UML)
				subtype (EER)
				subtype (ORM)
				
		 * @param $name object type name
		 */
		
		function __construct($name){
			
			$this->objectTypeName = $name;
		}
		
		function get_json_array(){
			return ["name" => $this->objectTypeName];
			
		}
		
		/**
		 * Generate ORM entity types from metamodel object types
		 */
		
		function equivORMEntityType(){
			return ["name" => $this->objectTypeName]; 
			
		}
		
		/**
		 * Generate EER entity from metamodel object types
		 */
		
		function equivEEREntity(){
			return ["name" => $this->objectTypeName];
				
		}
		
		/**
		 * Generate UML classes from metamodel object types
		 */
		
		function equivUMLClass(){
			return ["name" => $this->objectTypeName, "attrs" => [], "methods" => []];
		
		}


	}

?>