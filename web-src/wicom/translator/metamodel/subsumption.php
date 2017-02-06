<?php
/*

Copyright 2017

Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA) -
Facultad de Informática
Universidad Nacional del Comahue

subsumption.php

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
load('relationship.php');


	class Subsumption extends Relationship{
		
		protected $objectSubName = "";
		protected $parentSub = "";
		protected $childrenSub = [];
		
		/**
		 More precisely regarding the sub and super:
			For each sub participating in a Subsumption, 
       			there must be a matching super and its participating Entity is of the same category as the 
       			Entity participating in the sub.
		`category' in the textual constraint refers to that a subsumption can be declared among 
		any two Relationships, between any two Object types etc., but not between, say, an 
		Object type and an Attributive property.
		
		 * @param $name subsumption name
		 * @param $parent subsumption parent
		 * @param $children subsumption array of parent's children
		 */
		
		function __construct($name,$parent,$children){
				
			$this->objectSubName = $name;
			$this->parentSub = $parent;
			$this->childrenSub = $children;
			
		}

		function get_json_array(){
				return ["name" => $this->objectSubName,
						"parent" => $this->parentSub,
						"children" => $this->childrenSub,
				];
				
		}

	}

?>