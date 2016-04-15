# CROWD

* `web-src` : Web directory for Apache or Nginx web server.

# Requirements

* Install Apache o Nginx web server with PHP5 module support.
* [Fish shell](http://fishshell.com).
* nodejs, npm and [coffee-script](http://coffeescript.org/) (see below for installation of the latter using npm).

# Installation

You can run the `scripts/install.fish` script, it will setup the current working directory, or you can do the following steps:

* Copy `web-src` into the web directory (usually `/var/www/html` for the Apache server).
* Copy the `web-src/config/config.php.example` into `web-src/config/config.php` and open the file.
	* Check the configuration parameters at the `config.php` file.
* Ensure that the web server can access the "run" directory. It needs to write `./run/input-file.owllink` file. 
  You can execute (suppose "www-data" is the username associated to the web server):
  ```
  sudo chgrp -R www-data run
  sudo chown -R g+rwx run
  ```
  On some systems, you may have to configure SELinux parameters to enable Apache writing privileges.
  You can use the `./tests/test-satisf-json.sh` for checking if it is correctly set.

## Install CoffeeScript Compiler

1. Install `nodejs` and `npm`.
2. Install coffee by executing `sudo npm install -g coffee-script`
3. Test the `coffee` command, it must open a CoffeeScript shell. Exit with `Ctrl d`.

## Compile CoffeeScript

Use the `scripts/compilar-coffee.sh` script located under the root project directory.

## Installing Coffee script on Eclipse Mars.1 Release (4.5.1)

* From Eclipse -> Help -> Install New Software... install

1. Install plugin Xtext complete SDK from 

2. Install plugin Coffee script plugin https://github.com/adamschmideg/coffeescript-eclipse

## Generating js code from coffee script Eclipse Mars.1 Release (4.5.1)

1. Create an External Tools Configuration
2. Location: add path to compile coffee.sh
3. Working Directory: path to Eclipse project.

# Test
At the `./test/` directory you'll find proper fish scripts for running tests.

## Javascript

## PHP
Install [PHPUnit](https://phpunit.de/getting-started.html) for testing. 

Execute:

```bash
cd tests
./test_php.fish
```

# Documentation
Use `doxygen` or `doxywizard` (the Doxygen GUI) for compiling the PHP documentation on `docs/doxygen`. 

* Execute `doxygen` command on the main directory, or
* Execute `doxywizard` and open the Doxyfile on the main directory; then click on the "run doxygen" button in the "run" tab.

# Licence

Images :

* Traffic Lights downloaded from OpenClipart at: https://openclipart.org/detail/195669/green-traffic-light
