/*  interfaz.js --
    Copyright (C) 2016 Giménez, Christian

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/**
   Un poco de aliasing para acortar el código.
*/
var uml = joint.shapes.uml;

/* ---------------------------------------------------------------------- */

var graph = new joint.dia.Graph;

var paper = new joint.dia.Paper({
    el: $('#container'),
    width: 1000,
    height: 1000,
    model: graph,
    gridSize: 1
});

/* CSS's */
css_clase = {
    '.uml-class-name-rect' : {
	fill: "#fff"
    },
    '.uml-class-attrs-rect' : {
	fill: "#fff"
    },
    '.uml-class-methods-rect' : {
	fill: "#fff"
    }
};

/* Interfaz */

/**
   CrearClaseView proporciona los elementos y eventos necesarios
   para mostra una interfaz para crear una clase.
*/
var CrearClaseView = Backbone.View.extend({    
    initialize: function(){
	this.render();
    },
    
    render: function(){
	var template = _.template( $("#template_crearclase").html(), {} );
	this.$el.html(template);
    },

    events: {
	"click a#crearclase_button" : "crear_clase",
    },

    crear_clase: function(event){
	alert("Creando: " + $("#crearclase_input").val() + "...");
	nueva = new uml.Class({
	    position: {x: 20, y:20},
	    size: {width: 220, height: 100},
	    name: $("#crearclase_input").val(),
	    attributes: [],
	    methods: [],
	    attrs: css_clase
	});

	graph.addCells([nueva]);
    }
});


/**
   Instancia de CrearClaseView.
*/
var crearclase = new CrearClaseView({el: $("#crearclase")});
