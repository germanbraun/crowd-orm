<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   racer-test.php
   
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

require_once("common/import_functions.php");
load("racerconnector.php", "wicom/reasoner/");

$racer = new Wicom\Reasoner\RacerConnector();
$answer = null;
$input = '<?xml version="1.0" encoding="UTF-8"?>
<RequestMessage xmlns="http://www.owllink.org/owllink#"
		xmlns:owl="http://www.w3.org/2002/07/owl#" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xsi:schemaLocation="http://www.owllink.org/owllink# 
				    http://www.owllink.org/owllink-20091116.xsd">
  <CreateKB kb="http://localhost/kb1" />
  <Tell kb="http://localhost/kb1">
    <!-- <owl:ClassAssertion>
      <owl:Class IRI="Person" />
      <owl:NamedIndividual IRI="Mary" />
      </owl:ClassAssertion>
      -->
    
    <owl:SubClassOf>
      <owl:Class IRI="Person" />
      <owl:Class abbreviatedIRI="owl:Thing" />
    </owl:SubClassOf>
  </Tell>
  <!-- <ReleaseKB kb="http://localhost/kb1" /> -->
</RequestMessage>
';


?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
	<?php
	include '_headincludes.php'
	?>
	<title>Racer Test</title>
    </head>

    <body>
	<div data-role="page">
	    <div data-role="header">		
		<h1>Racer Test</h1>
	    </div><!-- /header -->

	    <div role="main" class="ui-content">
		<div data-role="controlgroup" data-type="vertical">
		    <div class="input">
			<h1 class="ui-bar ui-bar-a ui-corner-all">Input</h1>
			<div class="ui-body ui-body-a ui-corner-all">
			    <textarea col="100">
				<?php echo $input; ?>
			    </textarea>
			</div>
		    </div>

		    <?php		    
		    try{			
			$racer->run($input);
			
		    }catch(Exception $e){
		    ?>
			<div class="exception">
			    <h1 class="ui-bar ui-bar-a ui-corner-all">Exception appears!</h1>
			    <div class="ui-body ui-body-a ui-corner-all">
				<textarea cols="100">
				    <?php echo $e->getMessage(); ?>
				    </textarea>
			    </div>
			</div>
		    <?php 
		    }			
		    ?>

		    <div class="answer">
			<h1 class="ui-bar ui-bar-a ui-corner-all"> Answer</h1>
			<div class="ui-body ui-body-a ui-corner-all">
			    <textarea cols="100">
				<?php echo $racer->get_col_answers()[0]; ?>
			    </textarea>				  
			</div>
		    </div>


		    <a class="ui-btn ui-icon-back ui-btn-icon-left" data-ajax="false"
		       href="./index.php">Volver</a>
		</div>
	    </div> <!-- /main -->
	    
	    <div data-role="footer">	
		<address>
		    <a href="mailto:christian@Harmonia">Giménez, Christian</a>,
		    12 feb 2016
		</address>
	    </div><!-- /footer -->
	</div><!-- /page -->
    </body>
</html>
