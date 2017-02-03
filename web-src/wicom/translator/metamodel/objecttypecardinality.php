<?php
namespace Wicom\Translator\Metamodel;
use function \load;
load('cardinalityconstraint.php');


	class Objecttypecardinality extends Cardinalityconstraint{

		protected $objectRelName = "";
		protected $objCardinalityRel = [];
		
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
