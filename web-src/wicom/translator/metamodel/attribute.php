<?php
namespace Wicom\Translator\Metamodel;
use function \load;
load('attributeproperty.php');


	class Attribute extends AttributeProperty{

		protected $objClassAttr = "";
		protected $objectAttrName = "";
		protected $objAttrDataType = "";
		
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

	}

?>
