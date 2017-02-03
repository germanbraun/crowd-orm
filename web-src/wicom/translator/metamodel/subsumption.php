<?php
namespace Wicom\Translator\Metamodel;
use function \load;
load('relationship.php');


	class Subsumption extends Relationship{
		
		protected $objectSubName = "";
		protected $parentSub = "";
		protected $childrenSub = [];
		
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