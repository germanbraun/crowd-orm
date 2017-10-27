<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
	<?php
	include '_headincludes.php'
  ?>
  <!-- bootstrap css -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">

  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>

	<title>crowd, the ontologist</title>

	<link rel="stylesheet"  href="./css/interfaz.css" />
    </head>

    <body>
	<div data-role="page">
	    <div data-role="header">
		<h1 class="crowd-header">c r o w d</h1>
	    </div><!-- /header -->

	 <div role="main" class="ui-content">
<!--		<div data-role="controlgroup" data-type="horizontal"> -->
    <div class="container">
        <div class="row">
          <div class="col-sm-4">
		          <a class="btn btn-primary btn-lg active" rel="noopener" role="button" data-ajax="false"
		            href="./model_editor.php?type=UML">
              <img src="imgs/uml-jointjs.png" alt="UML" class="img-thumbnail img-responsive" height="400" width="400"/></a>
          </div>
          <div class="col-sm-4">
		          <a class="btn btn-primary btn-lg active" rel="noopener" role="button" data-ajax="false"
		            href="./model_editor.php?type=EER">
              <img src="imgs/eer-jointjs.png" alt="EER" class="img-thumbnail img-responsive" height="400" width="400"/></a>
          </div>
          <div class="col-sm-4">
		          <a class="btn btn-primary btn-lg active" rel="noopener" role="button" data-ajax="false"
		            href="./model_editor.php?type=ORM">
              <img src="imgs/orm-jointjs.png" alt="ORM" class="img-thumbnail img-responsive" height="500" width="500"/></a>
          </div>
        </div>
    </div>
	 </div> <!-- /main -->


	    <!-- a class="ui-btn ui-icon-gear ui-btn-icon-left" data-ajax="false"
	       href="./racer-test.php">Test the Racer Conection</a -->


<!--<div data-role="footer">
		<address>
		    <a href="mailto:christian@Harmonia">Giménez, Christian</a>,
		    12 feb 2016
		</address>
	    </div><!-- /footer -->
	</div><!-- /page -->
    </body>
</html>
