<?php
/*

Copyright 2017

Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA) -
Facultad de Informática
Universidad Nacional del Comahue

objecttypecardinality.php

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
load('cardinalityconstraint.php');


	class Objecttypecardinality extends Cardinalityconstraint{

		protected $objectRelName = "";
		protected $objCardinalityRel = [];
		
		/**
		 UML: multiplicity constraint; min max
		 EER: cardinality constraint; min cardinality, max cardinality 
		 ORM: frequency (object cardinality) constraint; min cardinality, max cardinality
		 
		 * @param $name relationship name
		 * @param $cardinality multiplicity associated to the relationship with $name
		 */
		
		function __construct($name,$cardinality){
		
			$this->objectRelName = $name;
			$this->objCardinalityRel = $cardinality;
		
		}
		
		function get_json_array(){
			return ["association" => $this->objectRelName,
					"min..max left" => $this->objCardinalityRel[0],
					"min..max right" => $this->objCardinalityRel[1]
			];
		
		}

	}

?>
