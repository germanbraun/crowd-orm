# Web - ICOM

* `web-src` : Directorio web para Apache.

# Instalación

* Usar Apache o Nginx con PHP5.
* Copiar `web-src` al directorio web de apache (usualmente /var/www/html), o al directorio configurado con Nginx.

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
## PHP
Use [PHPUnit](https://phpunit.de/getting-started.html) for testing. 

    phpunit --bootstrap src/autoload.php tests/MoneyTest

Or:

    php phpunit.phar --bootstrap src/autoload.php tests/MoneyTest
	
See instalation instruction at https://phpunit.de/getting-started.html

# Documentation
Use `doxygen` or `doxywizard` (the Doxygen GUI) for compiling the PHP documentation on `docs/doxygen`. 

* Execute `doxygen` command on the main directory, or
* Execute `doxywizard` and open the Doxyfile on the main directory; then click on the "run doxygen" button in the "run" tab.
