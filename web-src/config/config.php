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
$GLOBALS['config']['temporal_path'] = '/var/www/html/wicom/temp/';

?>