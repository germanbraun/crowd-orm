# Web - ICOM

* `web-src` : Directorio web para Apache.

# Instalación

* Usar Apache o Nginx con PHP5.
* Copiar `web-src` al directorio web de apache (usualmente /var/www/html), o al directorio configurado con Nginx.
* Create the directory `/home/wicom/racer` and copy (or symlink) the Racer-2.0 program there. 
    * Ensure it has write permissions for PHP and/or the web server process: `chmod a+rwx /home/wicom/racer`
    * If you want to use another directory, check `web-src/reasoner/racerconnector.php` file and change its constants. Ensure it is not a web accessible directory (i.e. it is not `/var/www/html/` or you cannot access it using your web server on http://localhost/...).

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
