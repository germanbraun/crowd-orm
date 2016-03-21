<?php
$GLOBALS['config'] = [];

/**
   What kind of environment is this?
   * 'devel' : Development. Non-minimal CSS and JS libraries and PHP
   code with information return.
   * 'prod' : Production. Minimal CSS and JS libraries and PHP
   without development output.
 */
$GLOBALS['environment']='devel';

/**
   Where I can store temporary files?

   For executing Racer, I need to store the OWLlink file, where I 
   should do this?

   Remember: Apache (represented as httpd, apache or www-data user in 
   some systems) should have write perms there.
 */
$GLOBALS['config']['temporal_path'] = '/var/www/html/wicom/run/';

/**
   Where is the Racer program?

   By default we provide a Racer program inside the temporal_path 
   (at wicom/run/Racer), but if you want to use another program you 
   have to set this value with the path.
 */
$GLOBALS['config']['racer_path'] = $GLOBALS['config']['temporal_path'];

?>