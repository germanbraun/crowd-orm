<?php
include './config/config.php'
?>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="author" content="Giménez, Christian">
<?php
if ($environment == 'production'){
?>
    <link rel="stylesheet" href="./css/joint.min.css" />
    <link rel="stylesheet" href="./css/jquery.mobile-1.4.5.min.css" />
    <script src="./js/libs/jquery.min.js"></script>
    <script src="./js/libs/jquery.mobile-1.4.5.min.js"></script>
    <script src="./js/libs/lodash.min.js"></script>
    <script src="./js/libs/backbone-min.js"></script>
    <script src="./js/libs/joint.min.js"></script>
    <!-- script src="./js/libs/joint.shapes.erd.min.js"></script -->
    <script src="./js/libs/joint.shapes.uml.min.js"></script>
<?php
}else{
?>
    <link rel="stylesheet" href="./css/joint.css" />
    <link rel="stylesheet" href="./css/jquery.mobile-1.4.5.css" />
    <script src="./js/libs/jquery.js"></script>
    <script src="./js/libs/jquery.mobile-1.4.5.js"></script>
    <script src="./js/libs/lodash.min.js"></script>
    <script src="./js/libs/backbone.js"></script>
    <script src="./js/libs/joint.js"></script>
    <!-- script src="./js/libs/joint.shapes.erd.js"></script -->
    <script src="./js/libs/joint.shapes.uml.js"></script>
<?php 
}
?>

<script src="./js/diagrama.js"></script>
<script src="./js/factories.js"></script>
<script src="./js/mymodel.js"></script>
<script src="./js/products.js"></script>

