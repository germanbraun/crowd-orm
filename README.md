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



