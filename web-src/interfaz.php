<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
	<?php
	include '_headincludes.php';
	?>
	<title>Interfaz</title>

	<script src="./js/interfaz.js"></script>
	
	<?php if (array_key_exists('prueba', $_GET) && $_GET['prueba'] == 1){ ?>
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
		<script type="text/template" id="template_editclass">
		    <form>
			<input type="hidden" id="editclass_classid" name="classid" value="<%= classid %>" />
			<input data-mini="true" placeholder="ClassName" type="text" id="editclass_input"  />
			<div data-role="controlgroup" data-mini="true" data-type="horizontal">
			    <a class="ui-btn ui-corner-all ui-icon-check ui-btn-icon-notext" type="button" id="editclass_button">Accept</a>
			    <a class="ui-btn ui-corner-all ui-icon-delete ui-btn-icon-notext" type="button" id="close_button">Close</a>
			</div>
		    </form>
		</script>
		<script type="text/template" id="template_classoptions">
		    <div class="classOptions" data-role="controlgroup" data-mini="true" data-type="vertical" style="visible:false, z-index:1, position:absolute" >
			<input type="hidden" id="cassoptions_classid" name="classid" value="<%= classid %>" />
			<a class="ui-btn ui-icon-delete ui-btn-icon-left" type="button" id="deleteclass_button">Delete</a>
		    </div>
		</script>
		
		<script src="./js/interfaz.js" type="text/javascript"></script>
		
		<div id="editclass"></div>
		<div id="classoptions"></div>
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
