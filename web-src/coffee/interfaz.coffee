# interfaz.coffee --
# Copyright (C) 2016 Giménez, Christian

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# {Diagrama} = require './diagrama'
# {Class} = require './mymodel'

# Un poco de aliasing para acortar el código.
uml = joint.shapes.uml;

# ---------------------------------------------------------------------- 

graph = new joint.dia.Graph
diag = new Diagrama(graph)

paper = new joint.dia.Paper(
        el: $('#container')
        width: 1000
        height: 1000
        model: graph
        gridSize: 1
)

css_clase = 
        '.uml-class-name-rect' : 
            fill: "#fff"
        '.uml-class-attrs-rect' : 
        	fill: "#fff"
        '.uml-class-methods-rect' : 
        	fill: "#fff"
        
# Interfaz

##
# CrearClaseView proporciona los elementos y eventos necesarios
#   para mostra una interfaz para crear una clase.
CrearClaseView = Backbone.View.extend(    
        initialize: () ->
        	this.render()
    
        render: () ->
                template = _.template( $("#template_crearclase").html(), {} )
                this.$el.html(template)

        events: 
        	"click a#crearclase_button" : "crear_clase"

        crear_clase: (event) ->
            alert("Creando: " + $("#crearclase_input").val() + "...")
            nueva = new Class($("#crearclase_input").val(), [], [])
            diag.agregar_clase(nueva)
);


# Instancia de CrearClaseView.
# 
crearclase = new CrearClaseView({el: $("#crearclase")});

exports = exports ? this

exports.graph = graph
exports.diag = diag
exports.paper = paper
