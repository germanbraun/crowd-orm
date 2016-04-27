<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
	<?php
	include '_headincludes.php'
	?>
	<title>Inicio</title>
    </head>

    <body>
	<div data-role="page">
	    <div data-role="header">		
		<h1>WICOM</h1>
	    </div><!-- /header -->

	    <div role="main" class="ui-content">
		<div data-role="controlgroup" data-type="vertical">
		    <a class="ui-btn ui-icon-gear ui-btn-icon-left" data-ajax="false"
		       href="./racer-test.php">Prueba de conexión a Racer</a>
		    <a class="ui-btn ui-icon-edit ui-btn-icon-left" data-ajax="false"
		       href="./interfaz.php">Editar un diagrama</a>
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
