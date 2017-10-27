<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
	<?php
	include '_headincludes.php'
	?>
	<title>crowd</title>
	
	<link rel="stylesheet"  href="./css/interfaz.css" />
    </head>

    <body>
	<div data-role="page">
	    <div data-role="header">		
		<h1 class="crowd-header">c r o w d</h1>
	    </div><!-- /header -->

	    <div role="main" class="ui-content">
		<div data-role="controlgroup" data-type="horizotal">
		    <a class="ui-btn ui-icon-edit ui-btn-icon-top" data-ajax="false"
		       href="./model_editor.php?type=UML">UML</a>
		    <a class="ui-btn ui-icon-edit ui-btn-icon-top"  data-ajax="false"
		       href="./model_editor.php?type=EER">EER</a>
		</div>
	    </div> <!-- /main -->

	    
	    <!-- a class="ui-btn ui-icon-gear ui-btn-icon-left" data-ajax="false"
	       href="./racer-test.php">Test the Racer Conection</a -->
	    
	    
	    <div data-role="footer">	
		<address>
		    <a href="mailto:christian@Harmonia">Giménez, Christian</a>,
		    12 feb 2016
		</address>
	    </div><!-- /footer -->
	</div><!-- /page -->
    </body>
</html>
