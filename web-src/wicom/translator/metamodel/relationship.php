<?php
namespace Wicom\Translator\Metamodel;
use function \load;
load('entity.php');


	class Relationship extends Entity{

		
		protected $objectRelName = "";
		protected $objEntitiesRel = [];
		
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