<?php
// $curl_command = "curl -0 --crlf -d@owllink-example-LoadOntologies-request-20091116.xml http://127.0.0.1:8080";
$url = "http://127.0.0.1:8080";
$archivo = "owllink-example-LoadOntologies-request-20091116.xml";
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>Prueba</title>
	<meta name="author" content="Giménez, Christian">
    </head>
    
    <body>
	<h1>Prueba</h1>
	
	<?php
	$res = curl_init($url);
	
	$cfile = new CURLFile($archivo);
	$data = array('file' => $cfile);

	// curl_setopt($res, CURLOPT_HEADER, 0);
	curl_setopt($res, CURLOPT_POST, 1);
	curl_setopt($res, CURLOPT_POSTFIELDS, $cfile);
	curl_setopt($res, CURLOPT_SAFE_UPLOAD, false); // requerido a partir de PHP 5.6.0
	curl_setopt($res, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
	?>
	<pre class="xml-output">
	    <?php
	    curl_exec($res);
	    curl_close($res);
	    ?>
	</pre>
	
	<hr>
	<address>
	    <a href="mailto:christian@Harmonia">Giménez, Christian</a>,
	    09 feb 2016
	</address>
    </body>
</html>

