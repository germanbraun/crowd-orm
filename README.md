# Web - ICOM

* `web-src` : Directorio web para Apache.

# Instalación

* Usar Apache o Nginx con PHP5.
* Copiar `web-src` al directorio web de apache (usualmente /var/www/html), o al directorio configurado con Nginx.
* Ensure that the web server can access the temp directory here. It needs to write ./temp/input-file.owllink file. 
  You can execute (suppose "www-data" is the username associated to the web server):
  ```
  sudo chgrp -R www-data temp
  sudo chown -R g+rwx temp
  ```
  On some systems, you may have to check SELinux to enable Apache writing.
  You can use the `./tests/test-satisf-json.sh` for checking if it is correctly setted.

## Instalar Compilador de CoffeeScript

1. Instalar `npm` y `nodejs`.
2. Instalar coffee usando `sudo npm install -g coffee-script`
3. Probar `coffee`, debe abrir una terminal.

## Compilar CoffeScript

Utilizar `scripts/compilar-coffee.sh` bajo el directorio raiz del proyecto.

## Installing Coffee script on Eclipse Mars.1 Release (4.5.1)

* From Eclipse -> Help -> Install New Software... install

1. Install plugin Xtext complete SDK from 

2. Install plugin Coffee script plugin https://github.com/adamschmideg/coffeescript-eclipse

## Generating js code from coffee script Eclipse Mars.1 Release (4.5.1)

1. Create an External Tools Configuration
2. Location: add path to complile coffee.sh
3. Working Directory: path to Eclipse project.

# Test
At the `./test/` directory you'll find proper fish scripts for runing tests.

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
