# Developing

Ensure you're using:

* UTF-8 encoding.
* 4 spaces per indentation.
* Indentation **must be spaces** not tabs.

# Directory Structure

* `./model/*.coffee` : Our model of the crowd objects. Factory (where our Joint views and models are created) are also here.
* `./views/*.coffee` : Backbone's Views for templates. There is one view per template here. 

## On JS directory

CoffeeScripts are compiled and merged into the JS directory, its directory structure is as follows:

* `../js/libs/*.js` : Libraries in pure JS downloaded and required for the web application to work. JQuery, Backbone and Joint are here as well as their dependencies. This directory should not be modified by the compilation process.
* `../js/model/` : Temporary directory where the model's CoffeeScript is compiled before merging into `../js/model.js` file. All files here is deleted after merging when running the compile script.
* `../js/views/` : Same as the model directory, a temporary place where Backbone's views CoffeeScripts are compiled for later merging on the backbone_views.js file. Files placed here are deleted after the merging when running the compile script.

# Emacs

On each script you can try to compile it alone using `C-c C-k` keys to see if it is properly written. 

# Documentation

Se Main Readme.  We use [codo](https://github.com/coffeedoc/codo), but [docco](http://jashkenas.github.io/docco/) can be used too.

# Compiling into JS

Go to the crowd main directory (where the `scripts` directory is) and execute:

```
scripts/compile-coffee.fish
```

You need the [Fish shell](http://fishshell.com). See Main Readme for more info.
