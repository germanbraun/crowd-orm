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

