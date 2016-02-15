<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>Interfaz</title>
	<meta name="author" content="Gimenez, Christian" />
	<link rel="stylesheet" href="./css/joint.min.css" />
	<link rel="stylesheet" href="./css/jquery.mobile-1.4.5.min.css" />
	<script src="./js/libs/jquery.min.js"></script>
	<script src="./js/libs/jquery.mobile-1.4.5.min.js"></script>
	<script src="./js/libs/lodash.min.js"></script>
	<script src="./js/libs/backbone-min.js"></script>
	<script src="./js/libs/joint.min.js"></script>
	<!-- script src="./js/libs/joint.shapes.erd.min.js"></script -->
	<script src="./js/libs/joint.shapes.uml.min.js"></script>
	<?php if ($_GET['prueba'] == 1){ ?>
	    <script src="./js/prueba.js"></script>
	<?php } ?>
    </head>

    <body>
	<div data-role="page">
	    <div data-role="panel" data-position="left" id="tools-panel" class="comandos" id="comandos">
		<div id="crearclase"></div>
	    </div><!-- /panel -->

	    <div data-role="header">
		<h1>Interfaz</h1>
		<a href="#tools-panel" class="ui-btn ui-icon-bars ui-btn-icon-left">Herramientas</a>
	    </div> <!-- /header -->

	    <!-- ---------------------------------------------------------------------- -->
	    
	    <div role="main" class="ui-content">
		<div id="container"></div>
		
		<!-- Templates -->
		<script type="text/template" id="template_crearclase">
		    <div data-role="navbar">
			<label>Crear Clase</label>
			<input data-mini="true" placeholder="ClassName" type="text" id="crearclase_input"/>
			<a class="ui-btn ui-icon-plus ui-btn-icon-left" type="button" id="crearclase_button">Crear</a>
		    </div>
		</script>
		
		<script src="./js/interfaz.js" type="text/javascript"></script>
 	    </div> <!-- /main ui-content -->

	    <!-- ---------------------------------------------------------------------- -->
	
	    <div data-role="footer">
		<address>
		    <a href="mailto:christian@Harmonia">Giménez, Christian</a>,
		    10 feb 2016
		</address>
		
	    </div><!-- /footer -->
	</div> <!-- /page -->
    </body>
</html>
