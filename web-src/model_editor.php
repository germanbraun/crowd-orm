<?php
require_once('template.php');
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
	<?php
	include '_headincludes.php';
	?>
	<title>crowd, the ontologist</title>

	<script src="./js/csstheme.js"></script>
	<script src="./js/backbone_views.js"></script>
	<script src="./js/GUIState.js"></script>
	<script src="./js/model.js"></script>
	<script src="./js/interface.js"></script>
	<script src="./js/gui.js"></script>
    	<script src="./js/login.js"></script>
	<script src="./js/guiimpl.js"></script>
	<script src="./js/guiorm.js"></script>
	<script src="./js/guiuml.js"></script>
	<script src="./js/guieer.js"></script>
	

	<?php if (array_key_exists('prueba', $_GET) && $_GET['prueba'] == 1){ ?>
	    <script src="./js/prueba.js"></script>
	<?php } ?>

        <link rel="stylesheet" href="./css/interfaz.css" />
    </head>

    <body>
	<div data-role="page" id="diagram-page">
	    <div data-role="panel" data-display="reveal" data-position="left" id="tools-panel" class="comandos ui-corner-all" id="comandos">
		<div style="text-align: right">
		    <a href="#comandos" data-rel="close" class="ui-btn ui-icon-bars ui-btn-icon-notext ui-corner-all ui-btn-inline ui-mini">Close</a>
		</div>
		<div id="crearclase"></div>
	    </div><!-- /panel -->

	    <div data-role="header" class="wicom-header">
		<h1 class="crowd-header">c r o w d</h1>
		<div id="trafficlight"></div>
		<div data-role="navbar">
		    <ul>
			<li><a href="#tools-panel" data-transition="slide" class="ui-btn ui-icon-bars ui-btn-icon-left">UML</a></li>
			<li><a href="#details-page" data-transition="slide" class="ui-btn ui-btn-icon-left ui-icon-forward">Reasoning Details</a></li>
			<li><a href="#verbalisation-page" data-transition="slide" class="ui-btn ui-btn-icon-right ui-icon-forward">Verbalisation</a></li>
   			<li><a href="#user-page" data-transition="slide" class="ui-btn ui-icon-user ui-btn-icon-right">Profile</a></li>
		    </ul>
		</div>
	    </div> <!-- /header -->

	    <!-- ---------------------------------------------------------------------- -->

	    <div role="main" class="ui-content">
		<div id="errorwidget_placer"></div>
		<div id="importjsonwidget_placer"></div>
		<div id="container"></div>


		<!-- ---------------------------------------------------------------------- -->
		<!-- Templates -->
		<?php
		insert_template("errorwidget");
		insert_template("tools_navbar");
		insert_template("editclass");
		insert_template("classoptions");
		insert_template("relationoptions");
		insert_template("isaoptions");
		insert_template("trafficlight");
		insert_template("insertowllink");
		insert_template("importjson");
		insert_template("exportjson");
		insert_template("tools_navbar");
		insert_template("done_widget");
		?>

		<div id="editclass"></div>
		<div id="classoptions"></div>
		<div id="relationoptions"></div>
		<div id="isaoptions"></div>
		<div id="donewidget"></div>

 	    </div> <!-- /main ui-content -->

	    <!-- ---------------------------------------------------------------------- -->

	    <div data-role="footer">
		<address>
		    <a href="mailto:crowd@Harmonia">Facultad de Informática, Universidad Nacional del Comahue (Argentina)</a>
		</address>

	    </div><!-- /footer -->
	</div> <!-- /page -->

	<!-- ---------------------------------------------------------------------- -->
	<!-- Details page -->
	<div data-role="page" id="details-page">
	    <div data-role="header" class="wicom-header">
		<h1>Reasoning Details</h1>
		<div data-role="navbar">
		    <ul>
			<li><a class="ui-btn ui-icon-back ui-btn-icon-left" href="#" data-rel="back">Back</a></li>
		    </ul>
		</div>
	    </div>

	    <div role="main" class="ui-content">
		<div id="details_panel">
		    <h1 id="details">Details</h1>
		    <div id="translation_details">
			<h3 class="ui-bar ui-bar-a ui-corner-all">Translation Output</h3>
			<div class="ui-body">
			    <div id="html-output"></div>
			    <textarea cols="10" id="owllink_source"></textarea>
		    	    <a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all" type="button" id="translate_button"
			    onclick="guiinst.translate_owllink()">Translate Again</a>
			</div>
		    </div>

		    <div class="exportjson_details" data-role="collapsible" data-collapsed="true"
			 data-collapsed-icon="carat-d" data-expanded-icon="carat-u">
			<h2>JSON Export String</h2>
			<div id="exportjson_placer"></div>
		    </div>

		    <div class="insert_owllink_details" data-role="collapsible"  data-collapsed="true"
		    	 data-collapsed-icon="carat-d" data-expanded-icon="carat-u">
			<h2>Insert OWLlink</h2>
			<div id="owllink_placer"></div>
		    </div>
		    <div class="reasoner_details" data-role="collapsible" data-collapsed="true"
			 data-collapsed-icon="carat-d" data-expanded-icon="carat-u">
			<h2>Reasoner Details</h2>
			<h3 class="ui-bar ui-bar-a ui-corner-all">Reasoner Input</h3>
			<textarea cols="40" class="ui-body" id="reasoner_input"></textarea>
			<h3 class="ui-bar ui-bar-a ui-corner-all">Reasoner Output</h3>
			<textarea cols="40" class="ui-body" id="reasoner_output"></textarea>
		    </div>
		</div>
	    </div>
	    
	    <div data-role="footer"></div>
	</div> <!-- /page -->

 <!-- ---------------------------------------------------------------------- -->
	<!-- Verbalisation page -->
	<div data-role="page" id="verbalisation-page">
	    <div data-role="header" class="wicom-header">
		<h1>Verbalisation</h1>
		<div data-role="navbar">
		    <ul>
			<li><a class="ui-btn ui-icon-back ui-btn-icon-left" href="#" data-rel="back">Back</a></li>
		    </ul>
		</div>
	    </div>

	    <div role="main_verbalisation" class="ui-content">
		<div id="verbalisation_panel">
		    <h1 id="verbalisation">Verbalisation</h1>
		    <div id="verbalisation_details">
			<h3 class="ui-bar ui-bar-a ui-corner-all">Verbalisation Output</h3>
			<div class="ui-body">
			    <div id="html-output"></div>
			    <textarea cols="10" id="source_verbalisation">Verbalisation Here!</textarea>
		    	    <a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all" type="button" id="verbalise_button"
			    onclick="">Verbalise Again</a>
			</div>
		    </div>
		</div>
	    </div>
	    
	    <div data-role="footer"></div>
	</div> <!-- /page -->
	
	
<!-- ERD diagram page -->	
	


	<!-- -------------------------------------------------------------------------------- -->
	<!-- User Details Page -->
	<div data-role="page" id="user-page">
	    <div data-role="header" class="wicom-header">
		<h1>User</h1>
		<div data-role="navbar">
		    <ul>
			<li><a class="ui-btn ui-icon-back ui-btn-icon-left" href="#" data-rel="back">Back</a></li>
		    </ul>
		</div> <!-- /navbar -->
	    </div> <!-- /header -->

	    <div role="main" class="ui-content">

		<div data-role="navbar"></div>

        <div id="loginwidget_placer"></div>
		<div id="saveloadjson_placer"></div>

        <!-- Templates -->
        <?php
        insert_template("loginwidget");
        insert_template("saveloadjsonwidget");
        ?>

	    </div> <!-- /main -->

	    <div data-role="footer"></div>
	</div> <!-- /page -->
    </body>
</html>
