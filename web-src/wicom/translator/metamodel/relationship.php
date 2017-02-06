<?php
/*

Copyright 2017 

Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA) -
Facultad de Informática
Universidad Nacional del Comahue

relationship.php
 
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
load('entity.php');


	class Relationship extends Entity{

		
		protected $objectRelName = "";
		protected $objEntitiesRel = [];
		
		/**
		 UML: association, can be binary according to the MOF 2.4.1, but also >2-ary according to the Superstructure Spec 2.4.1
		 EER: relationship, >=2-ary
		 ORM: atomic/compound fact type, >=1-ary
		  For a Sub-relationship, the name is, respectively:
			subsetting or subtyping of association (UML)
			subtyping the relationship (not present in all EER variants)
			subset constraint on fact type (ORM)
		 
		 * @param $name represents the relationship name
		 * @param $entities is an array containing entities participating into the relationship
		 */
		
		function __construct($name,$entities){
		
			$this->objectRelName = $name;
			$this->objEntitiesRel = $entities;
				
		}
		
		function get_json_array(){
			return ["name" => $this->objectRelName,
					"classes" => $this->objEntitiesRel,
			];
		
		}

	}




?>