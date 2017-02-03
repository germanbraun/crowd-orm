<?php
namespace Wicom\Translator\Metamodel;
use function \load;
load('entitytype.php');


	class ObjectType extends EntityType{
		
		protected $objectTypeName = ""; 
		
		function __construct($name){
			
			$this->objectTypeName = $name;
		}
		
		function get_json_array(){
			return ["name" => $this->objectTypeName];
			
		}


	}

?>